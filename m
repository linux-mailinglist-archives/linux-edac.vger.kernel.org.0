Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A042B5A31C3
	for <lists+linux-edac@lfdr.de>; Sat, 27 Aug 2022 00:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241599AbiHZWMf (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 26 Aug 2022 18:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbiHZWMc (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 26 Aug 2022 18:12:32 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64696E1172;
        Fri, 26 Aug 2022 15:12:31 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27QM75Nj017551;
        Fri, 26 Aug 2022 22:11:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=PiMs6x7sCQSyJAzAp6P+khc9XOvaHYndC50tUzC6cQw=;
 b=WGw/CTz2i/tIeGRbUejl1Y3qL0RQtL+9ujMQwO36ChVGfCkuffWKQTCcu+I99p/vsttE
 0EcMUitbUqal3wOkyH2uzSKDysYnArJHY5tWTs3Ddtwt09JuTxob2KE5JcJCzQ7TkTkY
 QZ36AdnCAWEcVsC7oM60eylLeeJJKifBk2x2Zo4zTgm1j9G3MIwBj/B59yAi3VabpPrU
 BCYCKN42mbXKuHUlLZ68Y1goo8+w6vqRE5k6s3qSbmseppx8d+9kFgbYwsJce51OVMAI
 SWb8eWAQzTsxg6/ZNtNyiw4Vgo96GrQrj5CxwinPL+gaHcGJrMKZNpxtxHcunuZf5uvn 0A== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j5aww85tf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Aug 2022 22:11:39 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27QK4rsg018861;
        Fri, 26 Aug 2022 22:11:38 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j5n59qmtu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Aug 2022 22:11:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SgtvU7DsPxhSM8X9Rh7sNZBSrQ6sYZuNnT1h2tNpPZ+AZOPFUEiNTtN3Jq0ZOi4bLsQUx4cQGNZvBCsM7Q8neDYF7CQn226roZR4jDWFF6olbu+xnFPhTL10sPN0B3tBmQv+8Ig32xTaN4Ad5yoI06Ud9UKOsqszrquU6xMflU4cdvE97c7sjZtRxo5Gi8G4Z9lkjUYqnEbk2z4sy4GBpceZW4XMkNAKyDf4inuev+0koFcpuaVwCv26jbl3bBk4oHmVJilEJzi7Qe0Ny3fk4Ia0YmUYTqD0qPFfx9dSuBzWAVY0YzMroUxoNlPb/IU2FGSS273yIKjRSin7wthOXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PiMs6x7sCQSyJAzAp6P+khc9XOvaHYndC50tUzC6cQw=;
 b=XGxZelYmXncBoME04hBexfxWo2k53PtV2orH9vfkodiVrIvXIt/aNwxdwQA8Ebv/qeD8dzz3BAyfg+jt+XniOx6qzsYrPzyZZr+HMfr0i9/Ej9TieaIMk8+523KnpGIJuqFcoSnSWXHWotFkV6J2vtYjGtc0iRlUBHkSPcVngoW9Pt1K0ilFBnSwSb1r8RRW13pYJinSirOyIMu3Lf35o3EzHmgCWM/30A/2iJLNFLs29Rq0/5PCYOrJEkjHAMwvq+fY7pi8x7bm4cX+PN1nY0RTFHTDRenrOp6RrxwskqJ8S9W2sDftSDc8PiVIfZKU64TDlTPxKn9c2IE3/+U2qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PiMs6x7sCQSyJAzAp6P+khc9XOvaHYndC50tUzC6cQw=;
 b=QtujBGq+FnNczQmWKdSlBBiKS1g5SUsU2rKpULoDvUssnglofPoCp9Cv6D1tytpJ0dvWCQithvnt2hZTW7vqgwyR7irS4ZFboZqkWztb3pOtAZSnaSnfihxDnmz/BOPPtcOQRVG9f951l3va23mO4+PkJiMxXXaSH0dZWejYpv8=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by SJ0PR10MB5892.namprd10.prod.outlook.com (2603:10b6:a03:422::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Fri, 26 Aug
 2022 22:11:36 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::14cf:1363:8f81:9c81]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::14cf:1363:8f81:9c81%4]) with mapi id 15.20.5566.016; Fri, 26 Aug 2022
 22:11:36 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     Borislav Petkov <bp@alien8.de>,
        Dan Williams <dan.j.williams@intel.com>
CC:     "tony.luck@intel.com" <tony.luck@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>
Subject: Re: [PATCH v7] x86/mce: retrieve poison range from hardware
Thread-Topic: [PATCH v7] x86/mce: retrieve poison range from hardware
Thread-Index: AQHYpqk2x6w5xzWZA026ohxrqJ0Fu6280+EAgAMekwCAAGsvAIABPtOAgAAEEwCAAEPAgA==
Date:   Fri, 26 Aug 2022 22:11:36 +0000
Message-ID: <2cff660e-3e08-2cfc-adee-27c2dfdfd5db@oracle.com>
References: <20220802195053.3882368-1-jane.chu@oracle.com>
 <YwUFlo3+my6bJHWj@zn.tnic> <b3880db6-6731-1d1b-144f-1080a033ad01@oracle.com>
 <Ywf9ZL6zjzSf5pdF@zn.tnic>
 <630908d7e6937_259e5b29445@dwillia2-xfh.jf.intel.com.notmuch>
 <YwkMQsUn7BLPi5mU@zn.tnic>
In-Reply-To: <YwkMQsUn7BLPi5mU@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b82a5546-302a-4234-67c3-08da87aff12e
x-ms-traffictypediagnostic: SJ0PR10MB5892:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OT6rsj6BRNeFMeV/YCjHUYftP3/KLKRCwTGofumkdUqWKlckZETWGXdSTgsDEcJs3NO6b8l5BVdiadvoWfavnDqSgdjbzsQa7TpnrK8835d7q9B6X9JUKmUylXjJWY16dvYZrqR0HXkWr+x5YwAFTYvpXjtfcmJwc2/Q8aHE2hPwx7HGrDOCYWgXwRt+ncgXeyXK1oHz+qFPgi5aL9lK/DqqC+Hvk+TetUbSENc03BUQe782VocoCsEoWjAxzaPWkcQZ3usIZC27WrwbQUL/VtyCy2mSxxOEl11fX5r2PmQlq6KbKw4EgPS1nbSmbAmaAis+XcrNua+XU71okh96+gZ/zY3b1wUfzYgjQ3qcoVU5OuaqSHjOkmHAHMRzS/IEA7B+SWfEheALBJl0U1dAT24aH+xPs8ZgilNfjW2gUa4TU+OL1b8eh/SnL0zrVMdc0CGsIWhh41bzrbTCPLL8RwprE1V0oCRC+JWu8IZj/Z/CDY9fOWGU87OsFfj9KLM8QVMe8QbNiyrss4yvIPqT+A7cAkUCIA3g0rx3IKk6lUkgTIf/lH2U+mVkbyBIKElPxz4gP5Gd4Hcn224pOTch+3YxECEdmdmkSkQJRj4GnqpUMTYRLViRJfAs/o5e1RkQLqKgVLLjIjVE4Eq6HDYFRoIW9PeWwtGr91zxb8I1QgS2akLJm9cWKbI+ufPL1V/UtCy7YQzTvuxd4HVdwETGsSdFt/Ns/nsGqs/taV0zlJZDtQlPlIjo6zrUzRFnlOMJcCTpor6ZrejaQw+i7M4Nkef7tWgoXg6zgvcvUejm1Wi18EoTCJBF9y4/TTma98/D5GtdnjoVmwqiPGMcysPXaQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(39860400002)(376002)(366004)(136003)(396003)(83380400001)(6512007)(26005)(53546011)(6506007)(2906002)(186003)(86362001)(31696002)(2616005)(38070700005)(122000001)(38100700002)(110136005)(54906003)(6486002)(7416002)(8936002)(44832011)(41300700001)(66556008)(66946007)(5660300002)(316002)(76116006)(478600001)(71200400001)(66476007)(66446008)(64756008)(36756003)(4326008)(31686004)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U1RSTWxDOC9TQzl5TVBlb1pocU5LeFVNWHpLQ0owQ2VaMmErK01QOThPQ2hJ?=
 =?utf-8?B?REN6d0lxL1ZyT1ZBWmJ4YVQ3WWZ1dXYzRjQyUlRSM1BVT0VISjlJb0dKdzFT?=
 =?utf-8?B?U3grMHpLZzd5V0NEVVZZMFBBY1RmcnZXcjZ0eW9MSDlvcWszQnRDaGE3Qlhw?=
 =?utf-8?B?N2hlRVRocVJZaGpFcCtLWDFaTXlWUm82MDR2N21zUDJaYjJCdWlmdzhUWS9S?=
 =?utf-8?B?Q2g4SytvOFV1RDBlWUxYNWd1UlhIWkwrZGdzc0pUV3dTMmZONkNpaDRaRVBI?=
 =?utf-8?B?NjR5S09XM0xHbWNxUGJnOWt2VHVqWVB1SVBXY1lYb3ZXcmlJSXNkV3diRTF2?=
 =?utf-8?B?WGZDajhKY2d3TnRxRkdndi9uUWNNZk0ycmNYQVlCOS9OWGpPNENzSklRblVI?=
 =?utf-8?B?eUl2MlRITzE5UG1zcm44VG43dWJ3a0pmZDZIc3dTTzBnRWxFNFVnZ1JhVVdu?=
 =?utf-8?B?VURYRGdlZk96UGhRaGlwRHpZUFZHMy8yRjFBVjk4TGdZS0pKbGZMbWlKa2kz?=
 =?utf-8?B?cGpzRzMxRmlvMmN4bCtiWE41UlJCSFRSTnN4bElvS1lOSEFhWHp1YVk0Zy9W?=
 =?utf-8?B?ZHNwZkkvMlM1OWV2WDZPSlpvNE4wNXVpVmdPWHYybjc1aGRjZ2cwNHB0TGkv?=
 =?utf-8?B?VUt3WGxUU3ViRHBjMUhaQ054bGgrcTJFSW91aTBDQTNJVzJzeURnSzFpamlB?=
 =?utf-8?B?RzRuNmlLbG1JdzBzR3FVR3JsQ1IwazFSaVlBUXRmdVBHamQ3TXJoZXU1WC9L?=
 =?utf-8?B?N1pHSzQ0RS8zKy9qcTBua2psWjVtcVU4NlVmR2xBeUJXL3Y3UGRmc1VyT0ll?=
 =?utf-8?B?YWdWRHZ3U29lbDZBaEFYY1hHcGFiTmZQbGFjMHZyYlJiRDFJUXVmdnhGdFIy?=
 =?utf-8?B?eUJxa1RzeVRKWXdha01jNGF1RzA0RXJvMXhoekc0MDVuRUxnWXQxMkF0NEVu?=
 =?utf-8?B?bEdlN1BQRktHaytac0dXejhzUFBRMDhzMGg1UUgwOXZMWUkwbmNYS0hUTk9R?=
 =?utf-8?B?d3Q0Ni90Zk94bEs4dmdvQzV0ckxNUHplVi9aM1ViY2ZxSS92NTlYMHFXQXBP?=
 =?utf-8?B?MXlZU1NWMDhTYUNzVUFlV05teS9UNkRucGFvMGJpMU5hUEZnWHhlQ0hmZ0Iz?=
 =?utf-8?B?aS9rVWRLWkRwOXRvaHd5Zk0zNGx1M2xwV0QzbVpIMkp1WXhVamd3YlpZdzQx?=
 =?utf-8?B?M0lyRlNDcGpybndlaXA5UG5ENFZ4RDhLWG1vZit5Lzhwbkx1RGwveVRER1dz?=
 =?utf-8?B?NFlhbjEzZWZTRkM5NnBHZFlpYTBGK0hrSlFGV2Nva1VPV0hBK2VyczYwVm50?=
 =?utf-8?B?YXJjNlFSY09GdjEwTXlTWVZPRzNWcjEzTkt1QVJObERXdHpZVDNGU0FIY2Zv?=
 =?utf-8?B?WUROVnRJZDAvaEY0NWx6S3RieXN0bVRaS2Y4N0dZMkFVZTNQRmY3UG1zK0ZC?=
 =?utf-8?B?bnBGcVBSM04yK3hDWUc0VlhDYjdwUFhXYlNJUFJiQlltWUdJQmxIQkpON240?=
 =?utf-8?B?aUdoMnlUOG9WWmxGelV5UHF2VGtyaWMzbFhwZVVWaWNSdzFvelhYdTk2QzdX?=
 =?utf-8?B?Nkd3ZFpBUm8yQWJpV2FEVnJJQ0hTbDRLbHlWbUp4UE1ibDM1d2FsZWIyY3J3?=
 =?utf-8?B?VjNUZ25DQVlScW9yQ2Z4QXpPWHVwV001Smxhb3FiZTdmbjFXcnhXeC8wQTZk?=
 =?utf-8?B?NStoTmZUcXVLVTRucVR4RThRNWs0SXRPQU01U3NOUm1BY1ZxUzltblZEdkRJ?=
 =?utf-8?B?MFk0Qk5veXpoRkVlM3J6MjFiWmJiekZIei85cVFjcDZJaUxtdTh2Q0trcDRT?=
 =?utf-8?B?WWR4VTkyUkpGWFc4dUNCN1pmT1V0MHBRdHZTV0Y2cVM3enNDdzcyTS8wYk9l?=
 =?utf-8?B?amZ2MmIyWWc5ejluZXRTSEV6NkdYZnNadnFtMUkwdStZeW1ycGtRQmJZZ2tL?=
 =?utf-8?B?RmVuVTVxcmNPa3lPTmRJRFFlZDJSMHpHK0JseEF0N2dweW0wOGcwVHl5RHhE?=
 =?utf-8?B?bldMUWtvRVRFeVJXWWVRMjlCZlFiZmZVaW9pYmFidHRCTEd2Y1lOQXJXM0sv?=
 =?utf-8?B?cE5XQytzSi9ZOU9PMHRHc1FXOWdZNUltUWp4U1dHU1J3b0xjWmRWOXhwZGMv?=
 =?utf-8?Q?D92Y=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A2CFCCC396CA9646BE6AE7C87D35B210@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b82a5546-302a-4234-67c3-08da87aff12e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2022 22:11:36.1098
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NM/4dnSSDc725nGjeyoni+5bSX7RDxB5c9ElC9GHqbKMlvHVWy5zvD/6bFuCb4zG08QbLi7eUbbg2lGazIsqDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5892
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-26_12,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208260088
X-Proofpoint-GUID: oF4gZXHgg6v9Li6cLMB7lXJO2Hx0n90_
X-Proofpoint-ORIG-GUID: oF4gZXHgg6v9Li6cLMB7lXJO2Hx0n90_
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

T24gOC8yNi8yMDIyIDExOjA5IEFNLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6DQo+IE9uIEZyaSwg
QXVnIDI2LCAyMDIyIGF0IDEwOjU0OjMxQU0gLTA3MDAsIERhbiBXaWxsaWFtcyB3cm90ZToNCj4+
IEhvdyBhYm91dDoNCj4+DQo+PiAtLS0NCj4+DQo+PiBXaGVuIG1lbW9yeSBwb2lzb24gY29uc3Vt
cHRpb24gbWFjaGluZSBjaGVja3MgZmlyZSwNCj4+IG1jZS1ub3RpZmllci1oYW5kbGVycyBsaWtl
IG5maXRfaGFuZGxlX21jZSgpIHJlY29yZCB0aGUgaW1wYWN0ZWQNCj4+IHBoeXNpY2FsIGFkZHJl
c3MgcmFuZ2UuDQo+IA0KPiAuLi4gd2hpY2ggaXMgcmVwb3J0ZWQgYnkgdGhlIGhhcmR3YXJlIGlu
IHRoZSBNQ2lfTUlTQyBNU1IuDQo+IA0KPj4gVGhlIGVycm9yIGluZm9ybWF0aW9uIGluY2x1ZGVz
IGRhdGEgYWJvdXQgYmxhc3QNCj4+IHJhZGl1cywgaS5lLiBob3cgbWFueSBjYWNoZWxpbmVzIGRp
ZCB0aGUgaGFyZHdhcmUgZGV0ZXJtaW5lIGFyZQ0KPj4gaW1wYWN0ZWQuDQo+IA0KPiBZYXAsIG5p
Y2UuDQo+IA0KPj4gQSByZWNlbnQgY2hhbmdlLCBjb21taXQgNzkxN2Y5Y2RiNTAzICgiYWNwaS9u
Zml0OiByZWx5IG9uDQo+PiBtY2UtPm1pc2MgdG8gZGV0ZXJtaW5lIHBvaXNvbiBncmFudWxhcml0
eSIpLCB1cGRhdGVkIG5maXRfaGFuZGxlX21jZSgpDQo+PiB0byBzdG9wIGhhcmQgY29kaW5nIHRo
ZSBibGFzdCByYWRpdXMgdmFsdWUgb2YgMSBjYWNoZWxpbmUsIGFuZCBpbnN0ZWFkDQo+PiByZWx5
IG9uIHRoZSBibGFzdCByYWRpdXMgcmVwb3J0ZWQgaW4gJ3N0cnVjdCBtY2UnIHdoaWNoIGNhbiBi
ZSB1cCB0byA0Sw0KPj4gKDY0IGNhY2hlbGluZXMpLg0KPj4NCj4+IEl0IHR1cm5zIG91dCB0aGF0
IGFwZWlfbWNlX3JlcG9ydF9tZW1fZXJyb3IoKSBoYWQgYSBzaW1pbGFyIHByb2JsZW0gaW4NCj4+
IHRoYXQgaXQgaGFyZCBjb2RlZCBhIGJsYXN0IHJhZGl1cyBvZiA0SyByYXRoZXIgdGhhbiBjaGVj
a2luZyB0aGUgYmxhc3QNCj4gDQo+IHMvY2hlY2tpbmcvcmVhZGluZy8NCj4gDQo+PiByYWRpdXMg
aW4gdGhlIGVycm9yIGluZm9ybWF0aW9uLiBGaXggYXBlaV9tY2VfcmVwb3J0X21lbV9lcnJvcigp
IHRvDQo+IA0KPiBzL2luL2Zyb20vDQo+IA0KPj4gY29udmV5IHRoZSBwcm9wZXIgcG9pc29uIGdy
YW51bGFyaXR5Lg0KPj4NCj4+IC0tLQ0KPiANCj4gWWFwLCB0aGF0J3MgYSBsb3QgYmV0dGVyLg0K
PiANCj4gVGhhbmtzIQ0KDQoNCkdvdCBpdCBhbmQgcG9pbnRzIHRha2VuLiAgVGhhbmsgeW91IGJv
dGgsIEJvcmlzIGFuZCBEYW4uDQoNCnY4IGNvbWluZyB1cC4NCg0KdGhhbmtzLA0KLWphbmUNCg0K
DQo=
