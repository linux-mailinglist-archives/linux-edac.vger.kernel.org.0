Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8EE05A16B4
	for <lists+linux-edac@lfdr.de>; Thu, 25 Aug 2022 18:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241018AbiHYQab (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 25 Aug 2022 12:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241777AbiHYQa0 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 25 Aug 2022 12:30:26 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BE02558C7;
        Thu, 25 Aug 2022 09:30:24 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27PFnEuC012837;
        Thu, 25 Aug 2022 16:29:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=wRBT3dYm2V35p9otwxX253NTFyR6yRQnwHAWL933UwE=;
 b=gsfT4lcB6Tm8jleXRg/hmHX/ZAN8npjudwofIUpqVLOmbWFk+9RL+gjm7+FK9Bmt0GTF
 aggjU1ttNs2OjlBydsI9CnNRKKddNO1BUwBemJ31b1HTia2CDZ2sYjmgFUZK6zLyqXnH
 HKyCM7l6uBSHDoNcvyEZSS79Bwp496AMHudlWw5tfIBvrhNd9465EhBfTvSsAFgHzaP7
 hRvwEpAebhOO5GGnTcMmI6td5EHzs+EmeMcz7z+Qvn2/3Bn2ybv3iXZBwUF2yaIUiyLH
 rbILW8VHDBijh5x3sRp21Bifct+kFicVEIAUD3VzYefiI5CyMDd/qlreT5DnFd+9JPS7 lQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j55p25ab5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Aug 2022 16:29:50 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27PFJQBx017022;
        Thu, 25 Aug 2022 16:29:50 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j5n5pjb72-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Aug 2022 16:29:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TuDyS+oRbE1X7cnHBELGn9wbAEj37UXLORgxrUH1ZhZ3l6WlZEN/19woqzW7b3aHNGsVz4ZpkmR86z7QCjn8WP1CiIv8VF55bNF/1V6e/to4MoNHQfdFh4o/7vlx5hX8WZNY9kMayWw95+pAunxV+XVXkXAmucxn1iUI/4FBlg1DdyyjCASOjviGla3rTQQoARSvd6uAHtzAujo90c05MUzrlZy28rjXPySlYxK5nFL1o/77KQl0Ox8PjE91DXlBqkpzq4ScjsD+7TwfHR3utX40B3wft0RK6d5zQgeOb6XtjaqDA7fRPP07masGQ2w1dVpxJs0Ww6cT+ZtewALuQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wRBT3dYm2V35p9otwxX253NTFyR6yRQnwHAWL933UwE=;
 b=KMuce7mkKYifhyM1TCB2ndQS02mQkKBRY7OnBS8x5KbBh+iSB2kppY+7DLte/VDClXF3H6VsXOizbEtlcW206XVICqTGiyGyMpZ1iv5PfRDy6l77lkGag0N/G4wE0WR+r/I258B+jz4raDtyHJIXesiLXlyn9w6TQkr0i1HjA9USMIGp8/DkrAk1dRQY1SvhBHYku+sKf/uspy/mrnXGFnN+rL3kJwGgBof5ws1KqKHHy65ZJmPJnuptXiFBpK1ogtQahaSNAiL8YhjzhJMqtwR02RTgwO8OmHQwgJ4K35e+OMJsdYslw2mn2WAFSl+FTo9tmDZRVlxd1g6lKaa2jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wRBT3dYm2V35p9otwxX253NTFyR6yRQnwHAWL933UwE=;
 b=YudlGUQYJY3IDfQaK97d9CQWUUulwRIQLzxlG/p+sGuM846gXxtUQ/VHtCYsVUfxpx5JGEuyOQcYM3Ekcw4BhwKDIYB29oZq8v5SX2UoUXBS+pxUc47eW5s7CPEXgRMMElqEplocvzv1GdPkfS1uECS2fKPqIpY33AWd5vIjUVk=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by IA1PR10MB5993.namprd10.prod.outlook.com (2603:10b6:208:3ef::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Thu, 25 Aug
 2022 16:29:47 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::14cf:1363:8f81:9c81]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::14cf:1363:8f81:9c81%4]) with mapi id 15.20.5566.015; Thu, 25 Aug 2022
 16:29:47 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "tony.luck@intel.com" <tony.luck@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>
Subject: Re: [PATCH v7] x86/mce: retrieve poison range from hardware
Thread-Topic: [PATCH v7] x86/mce: retrieve poison range from hardware
Thread-Index: AQHYpqk2x6w5xzWZA026ohxrqJ0Fu6280+EAgAMekwA=
Date:   Thu, 25 Aug 2022 16:29:47 +0000
Message-ID: <b3880db6-6731-1d1b-144f-1080a033ad01@oracle.com>
References: <20220802195053.3882368-1-jane.chu@oracle.com>
 <YwUFlo3+my6bJHWj@zn.tnic>
In-Reply-To: <YwUFlo3+my6bJHWj@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3e6ccadf-09e5-4889-0821-08da86b706ab
x-ms-traffictypediagnostic: IA1PR10MB5993:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6zj10/Pp7jAmvpUoCc33FkCMwU0gOaHXAaAp5+oxkhbtSC8Q2U3w3VbB0sEqgdecq5JZxhr1JJglhXXSjDf7j8Anla+2xrnRmJTAVmzHmQysEHvykDaTgX6trH8zH+yfLiTEtaYTPTSTp/ITgypuppsKlQD4PtlJ0RXhX2z0uQSj27ZfRtkLm0Sy/V2ukhaYUM//KUDszPo7xnsk31VaiI4xlbFA9HvcyYfeCyBDc/dNShY3efn8n/v4PP5Yta50XCrW7LCrypyKim2R3Sx1NkfhShypy7nhvkl2ySdwDty2w5IOv3ro+aJ2w+Q+L8Lp8iaAWv71kRntATGekTrP80xkLMAcIpH5ynUz6PQ2nzzWIUPamCx6KKVXSHXsy5gvblTxkssFHq39/RMy+ikKW6XbwwcICx1U6HjeuxvjPFietEV91t61YxvFoCtsSpJqj8rIFNS8+sVMT4bRi4Uq6f6jl9gaIhfTZ+mVypVA696qqqDjfbEpNjzSwWbfvQoEF4kHCRFQuXCbC5CgwGqzL27lawONi1kIBcJo2gUb6XtibNGynpDrJ4wQmY4pUxq5a7pfO5TxBMn3YvzU2b7x55pqwjn1fv61Ml9yqeSBmL1LXM5RORdLBSXHxI8gsZX+xTGoul67Q4cyspxu7fZWHpWzu2YRhhs56WUr3Ejx83DVUoP2ijMjYiyKoCee5BiKrbGqWGol0J0RVmc/cGB6lIRaZW9cGtA5FvwB1qdJczKols7rBzCZxUpL5gPphyYh8SpkPET86+NdVEzq7QqPO3OJplZ9H6QvMZv/7dumQ16U0IbanZ1GuTZtz3vX6aCKpHeJinWMavqhL/2kwTxo/Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(39860400002)(376002)(366004)(136003)(396003)(2906002)(83380400001)(6512007)(53546011)(26005)(2616005)(186003)(6506007)(86362001)(31696002)(38070700005)(38100700002)(36756003)(122000001)(6916009)(54906003)(6486002)(7416002)(8936002)(76116006)(5660300002)(44832011)(66946007)(41300700001)(316002)(91956017)(66556008)(66446008)(71200400001)(478600001)(66476007)(64756008)(31686004)(8676002)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MTVpVW11bUU4SWY4bXp6S09TVmRJcmtRWXU5Z2g0OThCN09Zd21PZHg3eUNy?=
 =?utf-8?B?OUxmOTczYWFTTG0zc3BtUXp4eDhpZkVFL2RoeC95aXAwSzE3RXczdkhIMVQ5?=
 =?utf-8?B?YnlFckZlTVpTSXhESXZ2Uy9WeWlFVEg0VmJDakVuSDJ5TXNaOWpiYkZzRU9S?=
 =?utf-8?B?SWtzaXhSVUh0eGlUQVZhd0RCTnc0M2trNEQxRFM5Unk2R016SVd1MXgrMHlz?=
 =?utf-8?B?UWM5Mk5GRExyaEdCcGtpS0FQeHYvN2x0a2pkQUlPWDdodFNrSWhsU1h1a0sr?=
 =?utf-8?B?UFpqQzY5ZklqWEdGV3Y4a1BPemxGWnJWdmo3V1l0YnhtdExrTWhvSXVkNjNl?=
 =?utf-8?B?UHVNK1ROZVBjSGRCSlZFdWd6TlB0RmdsdUFDNWdxdExjTHRTLytsdFFzRVVY?=
 =?utf-8?B?Y1NvSHFUWVVTY05qRjlSQVpzZWR2YUE3eDlldzNiOUY3OTBHVGNJaUoyK09F?=
 =?utf-8?B?UEM5dGlJSHhGZVFJRitBZ3dNK0d3WW8zOUZ3S2VqQzJiMXRpblBJR1pGRTdU?=
 =?utf-8?B?cU5hWUd5SmV6N3ZCSzVaUGZyRTRtcitzMkhYZ0gzQ1BidWpSS1VrRXE1d2xW?=
 =?utf-8?B?aTdDYUFGL3ZoMHphOEp2cGJKLzBJZjBhWFFZY2huazg1aXpSRFpWNGk2cXlQ?=
 =?utf-8?B?ZEUzV3dWeUdQTEpncFU3NVIrNWQvTFZDM3VTeE1SOFo1Vm80bXNuRGZ3M2xM?=
 =?utf-8?B?TURMRTFDb0hBYjhEVjdyYmFyMUlOK0FwUitseFFveVQ1UlBtRkRkUC81THdt?=
 =?utf-8?B?Y1JNckp6bjlPQjgrenRYOEt6MGEyYVZyZjNrMStnc3hRcUNoNU9tZ1RreGVQ?=
 =?utf-8?B?dHNSaG8zTG95RCswT2syWTZibFJWYURIWE9INzlDK1FZV1pLUG5odytUSjFO?=
 =?utf-8?B?bUlYM3hRR25WYm1kazl3MmN6dExEWktMdmc0TEhrUzAzNDFrSnBaelNzVDNz?=
 =?utf-8?B?eldtNi9vaTVsbHZrS0tJQjFwMTBORXh5SHY2N1RYKzdhYnJWZzFCTk4vR0JZ?=
 =?utf-8?B?U1NaNjFpeUd5Tmh0SzJucURuZHBFTFZOZnBOYzVLTHdSNk1GejFsYkNOTkd2?=
 =?utf-8?B?ZTZBRkNvSGpkVFN3Y3FHL0RLTS9rdnlvVENSYW44NlFEdjdwb0N0Skk1R1Vh?=
 =?utf-8?B?MStVZGxjWkNlcENrQzd6L1MxR0hVYktZUXk0aFZNS1pMb2YrMStqR0RBMkR3?=
 =?utf-8?B?eUlVamk4YWJHL3pKMzlTVGNzZUg0OTZJZTQvMHF1VmZTOEh0ajJQaTRrcGJn?=
 =?utf-8?B?My9nVkJJZDZIRE5OKzVJaDdGak9nMWNuSklrNElBZEg1cVNJVHZUN3ZoSVha?=
 =?utf-8?B?Wkdya1hpZks2T1pTeCt4R0trMGs2Y0dCYlZBY01naUxMV01MSnhMdkpSUG1J?=
 =?utf-8?B?c05nNFRINXFibU9OWE04VHJYUWpFYUNwckJtRzkraGFHV1dJZ1dXUEJsb0sx?=
 =?utf-8?B?OGJlcnpUWDhpZ0QvOXJXTjF1RnU3SlBUK2ZjUDUvdkJUcDl4VDd2VVpGVzND?=
 =?utf-8?B?U3BmU01qZ2RKNFZidDRJZXFSdksvYWJYUUNKeVYyU3NBcytVbTlXUHQ1QVVU?=
 =?utf-8?B?U1Ixd084MkVBMk53UElwSmNIcW4vODNtQURBcVF0N2swRTNQSFUyQ3hIK1FF?=
 =?utf-8?B?azVHbURKaWZ5SitibS9Ha09HOVMyTXI5MXZEL21zWVd3b0o5NFJmZHl4aEt3?=
 =?utf-8?B?MklyNitUVmhDd0xzczI3dFlKUWhOSjVpSm5nUTJwYlpBY3l0ellreTlzT1g2?=
 =?utf-8?B?b0k0VTBDUFg1anpYM2RhcWpxTTNlZVlBUlpQclRPc3VSeW5PS2k4c2lWTzBn?=
 =?utf-8?B?dWsvZk5ZMGl5UXU1aXVZeEt2SlZwM0FJdzhyTXRKL0pOczdEVFlGTmh1TFlo?=
 =?utf-8?B?UTNKYUxueHFLakNoRHJPR0JJKzMyeFVvMnRYMXVNQXlrd25WcUw5b1lPbzNP?=
 =?utf-8?B?UlNXa2ZtWTZzUWxmZGwzMzhZU0tuNVZGRlVpWWNELzU0V3JiTVBKbG9kYlBw?=
 =?utf-8?B?Q0tpUFpjYVBadTBTcGtlTTdXZC9kejN4Tm9iTVNJT0k1emRVS0lOZmszaCtF?=
 =?utf-8?B?anVWZDNJbnA1a1JBZlVXU01meTVxNDhmS3JhU2JqMHBiWWdWdXdOWU9uYndI?=
 =?utf-8?Q?sFJ4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1D7E8DAC61E7A945BFECC50FE02CC02C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e6ccadf-09e5-4889-0821-08da86b706ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2022 16:29:47.4887
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ELLphqJggKSjEou3Tdb24vnOK2QHJxJ9oc1gYqLWdc17wsf1UzmUYkP4TVMZD00boR3dB2XJ69MFKkjMHwR66A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB5993
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-25_08,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 adultscore=0 mlxscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208250062
X-Proofpoint-ORIG-GUID: vf2HcPbHzUHpeb8MxAsleuN6Ed1NoNQt
X-Proofpoint-GUID: vf2HcPbHzUHpeb8MxAsleuN6Ed1NoNQt
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

T24gOC8yMy8yMDIyIDk6NTEgQU0sIEJvcmlzbGF2IFBldGtvdiB3cm90ZToNCj4gT24gVHVlLCBB
dWcgMDIsIDIwMjIgYXQgMDE6NTA6NTNQTSAtMDYwMCwgSmFuZSBDaHUgd3JvdGU6DQo+PiBXaXRo
IENvbW1pdCA3OTE3ZjljZGI1MDMgKCJhY3BpL25maXQ6IHJlbHkgb24gbWNlLT5taXNjIHRvIGRl
dGVybWluZQ0KPj4gcG9pc29uIGdyYW51bGFyaXR5IikgdGhhdCBjaGFuZ2VkIG5maXRfaGFuZGxl
X21jZSgpIGNhbGxiYWNrIHRvIHJlcG9ydA0KPj4gYmFkcmFuZ2UgYWNjb3JkaW5nIHRvIDFVTEwg
PDwgTUNJX01JU0NfQUREUl9MU0IobWNlLT5taXNjKSwgaXQncyBiZWVuDQo+PiBkaXNjb3ZlcmVk
IHRoYXQgdGhlIG1jZS0+bWlzYyBMU0IgZmllbGQgaXMgMHgxMDAwIGJ5dGVzLCBoZW5jZSBpbmpl
Y3RpbmcNCj4+IDIgYmFjay10by1iYWNrIHBvaXNvbnMgYW5kIHRoZSBkcml2ZXIgZW5kcyB1cCBs
b2dnaW5nIDggYmFkYmxvY2tzLA0KPj4gYmVjYXVzZSAweDEwMDAgYnl0ZXMgaXMgOCA1MTItYnl0
ZS4NCj4gDQo+IFdoYXQgSSdtIG1pc3NpbmcgZnJvbSB0aGlzIHRleHQgaGVyZSBpcywgd2hhdCAq
aXMqIHRoZSBtY2UtPm1pc2MgTFNCDQo+IGZpZWxkIGluIGh1bWFuIHNwZWFrPyBXaGF0IGRvZXMg
dGhhdCBmaWVsZCBkZW5vdGU/DQo+IA0KPiBXaGF0IGVmZmVjdCBkb2VzIHRoYXQgZmllbGQgaGF2
ZSBvbiBlcnJvciBpbmplY3Rpb24NClRvbnkgaGFzIHJlcGxpZWQuDQoNCj4gDQo+IEFuZCBzbyBv
bi4NCj4gDQo+PiBEYW4gV2lsbGlhbXMgbm90aWNlZCB0aGF0IGFwZWlfbWNlX3JlcG9ydF9tZW1f
ZXJyb3IoKSBoYXJkY29kZQ0KPj4gdGhlIExTQiBmaWVsZCB0byBQQUdFX1NISUZUIGluc3RlYWQg
b2YgY29uc3VsdGluZyB0aGUgaW5wdXQNCj4+IHN0cnVjdCBjcGVyX3NlY19tZW1fZXJyIHJlY29y
ZC4gIFNvIGNoYW5nZSB0byByZWx5IG9uIGhhcmR3YXJlIHdoZW5ldmVyDQo+PiBzdXBwb3J0IGlz
IGF2YWlsYWJsZS4NCj4gDQo+IFJlbHkgb24gaGFyZHdhcmU/IFlvdSdyZSBjaGFuZ2luZyB0aGlz
IHRvIHJlbHkgb24gd2hhdCB0aGUgZmlybXdhcmUNCj4gcmVwb3J0cy4NCj4gDQo+IFRoYXQgbWVt
X2VyciB0aGluZyBjb21lcyBmcm9tIGEgQklPUyB0YWJsZSBBRkFJQ1QuDQo+IA0KDQpXb3VsZCBm
aXggdGhlIGNvbW1lbnQgdG8gaW5kaWNhdGUgInJlbHlpbmcgb24gZmlybXdhcmUiIGhlbHA/DQpJ
cyB0aGVyZSBvdGhlciBjb25jZXJuPw0KDQp0aGFua3MhDQotamFuZQ0KDQo+IC4uLg0KPiANCj4g
VGh4Lg0KPiANCg0K
