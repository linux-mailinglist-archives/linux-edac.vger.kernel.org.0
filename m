Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57BF758CF75
	for <lists+linux-edac@lfdr.de>; Mon,  8 Aug 2022 22:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244455AbiHHU6c (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 8 Aug 2022 16:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238453AbiHHU63 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 8 Aug 2022 16:58:29 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F30C765C;
        Mon,  8 Aug 2022 13:58:28 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 278ItYnv013727;
        Mon, 8 Aug 2022 20:58:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=woQnVEXUgeMW6vvmpIU6pAzlhkoKkC++ZbVig77lT14=;
 b=PxTdpK51jwsGiogF66UkRZc9vjqpkU11Yf9XSPbXGxZ7kldw9N6xPUg4CbL8Ciir4EQs
 LsS30GKgShAD0sUJ/jd//RPHTv45ASQl8Y+Hq37rREO1q2l/J46+u42aEYOolOcoU84p
 WwvGPwfdpfcelLIbQpPZOgl7VHiQkBJZS49Bx5a1dXz1gLWaB9dsVA10z4GmFMFCdAHv
 vkyS+Qiz09jNvzGGjzNpkBtInWJ6xikTqzFqgYNp7nJqt5XosZtcEsJtPEt3PnJjEJsc
 1H+IlykXhvtDPKtTBlPcRa8c4J6nTmL83NktaN9Ocreu9XY6hKT7fJjTEgr8agycjce/ cg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hsf32cukk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Aug 2022 20:58:03 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 278ITjmI007752;
        Mon, 8 Aug 2022 20:58:02 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hser294h9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Aug 2022 20:58:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d8WbrLO7HBSVnRROc02lnHKvqGTiX7yV3HkFMizPxPL4WdYHX3Bk5yZudYVnoj2eIREVBP+16jgXiTZp93BbYHYHPMjf4eHPWM+EOQidiOBmU5YhLfPEJ06bU9A6RA4vHQdBNw89NYq4bkYUSGum/TwnGhzvQvMmA3YD8eHz8fV1yM3oywwCaUjf9dwDl7cAUQwIKsghuhcNA6450abM7Z7kGNyCOTUHlNnepJciuYS6p5x+h+sf9KkPeA7kQlHkUTro43qvq/3jQPYKpjWcGwGAGdCrVaO7bDdO4iDAWZalg97JpuWNJb+sE7QN1ai19eceoqRHtecbgMsjX+sLCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=woQnVEXUgeMW6vvmpIU6pAzlhkoKkC++ZbVig77lT14=;
 b=Th9kTiE6veOs90DDfLerTQhjPyjxnBdEGm3spO2zwdC8cNY9Km5k6pWYc2h8LOwc0JXYW2fv6N1ZvTp3ABeduX7ATB+NqsrfmD5MK8UMoBWpR4Zbd5Z8l+VDJ0nikfNzD+oSHp7PQjPS+ocwFV1uHvb/fS6GsDIixCW4xZf8kn3pizRRkvL/iz4lGiFi+cf0CHwI4m1yatkCx96lOnIwEkqwX3w0hGfrEi5RkeniSqSxAT9TeBYaCnUzyyl9yTw9ONyGk4Wc56RcO2NtbAaVYbG+hbJ9gA01LENpQyPXEdcG3auF3BBpxGopxd5T4J4GIt3okAXcrhPUqP6ezVJE/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=woQnVEXUgeMW6vvmpIU6pAzlhkoKkC++ZbVig77lT14=;
 b=WW4yju52wPdgInjz3Ln9WuLNZdbIw0MOC4GLfckM2DsUWo3/c5o6pPiVZtjeAzkiZhpxFdq3kzDy/p21E+tbd1tV683sNmQSnIBJinvmsrLZrdbdL1GvxcJxoFiTkIszjXjs0/f0dP+/Yw2LJoA4BqBy6xzwXJoowtAWBMoaEbY=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by DM6PR10MB2985.namprd10.prod.outlook.com (2603:10b6:5:71::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Mon, 8 Aug
 2022 20:58:00 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::b186:2073:e716:c126]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::b186:2073:e716:c126%7]) with mapi id 15.20.5504.020; Mon, 8 Aug 2022
 20:58:00 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     Ingo Molnar <mingo@kernel.org>
CC:     "tony.luck@intel.com" <tony.luck@intel.com>,
        "bp@alien8.de" <bp@alien8.de>,
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
Thread-Index: AQHYpqk2x6w5xzWZA026ohxrqJ0Fu62c35cAgAimK4A=
Date:   Mon, 8 Aug 2022 20:58:00 +0000
Message-ID: <833288b3-4838-63b8-b22b-f22538877957@oracle.com>
References: <20220802195053.3882368-1-jane.chu@oracle.com>
 <Yuo3dioqb9mDAOcT@gmail.com>
In-Reply-To: <Yuo3dioqb9mDAOcT@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cd9cb2eb-10a0-499b-77ce-08da7980adb3
x-ms-traffictypediagnostic: DM6PR10MB2985:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b14CG2RFkHQZ0mRW4G45SPT2hEMLNh1FIwKry6pM3p/GgVdnA5QexRPRN5YKkjaOTY4rvCJpYjExTkFy+4p1Wkk5DFtLVuraWZTYv4LIIuMdfMC/Axy7Ni6+qHdxqnqNR9DYF60hmpe8gtlfNV7cJX/pMv5AkajZd98X7Np5OLX+YmEe2fnclQuHaGbIMaPVdL03VAc26txTE67Rtl2DSfhrcQ2qJM2GqkK2w8P4cxqIz3Yvj/aw0KjB+od4nB8qOVcmBDMV+s0AQUGhM1hXmUKPwCY4LT7NjRW0mkcRuxS/j/KfQfA71vED6HCZJLAhCxZ5DmHDazYcg5GkKaZGngQGYuHWJkRodRBMJhxvmKt3BwiRBK0MBDm4GgW7JdpMNAH2R1muLOp91YGDvIJxxJLwwkv18mLnmPZu1KHP4KeXXtj6j7CQ/+i7D2RQbkck7GOLtaK7s5gxUirKIx1pQg0OfxC2ju/+8eca3DkG7mgYSG9zVcxnRaS+Sw9yPDtvnN8bn2GXf67QrosGueZl1iu53goYHIdIdGsdS/igz3ywwpNZKB++K7YTVrPANV8BmDaGHVK780kwL5AWIcbi0m2Napes6Dcqe1fBk+4YcrDjlKUtsJtA8fLFeKbnynyA8RpoT7SWf52r8bH5Aly+OXm8r6Cw7efi6oF79jbE6WIOVStaMcbvHSUnTLK0TDYnyFo/xe9YN9FZ3PL6FTbdh4Ox+LYIYxmIsedKtmZpI5SyYTb1mFQ8QzQ0SB5+9u9cOKElSJKafCs2qgXSknYQkFeAFG2lE7bf0ntBdjpn9f76USo+S985cTrP70MjxDb/zRmzYcBbhTuDZ1aPqpWh/dRP9vWKWoNAP1T28Kuql2uq47Ny0XR5IXgXR9ycaBhPHJzSz2f40C7Fn8Q6a9dolg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(366004)(376002)(39860400002)(136003)(396003)(31686004)(83380400001)(36756003)(26005)(6512007)(2616005)(186003)(91956017)(4326008)(76116006)(86362001)(316002)(53546011)(41300700001)(966005)(2906002)(6506007)(6916009)(478600001)(44832011)(66946007)(6486002)(66476007)(71200400001)(122000001)(64756008)(66556008)(7416002)(66446008)(38100700002)(5660300002)(31696002)(54906003)(8676002)(38070700005)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SnM0ZEc4VldqaXozOUkwaTBSczFwOEh1N25PYitvMlNMSExvK0VZUHVaS3ps?=
 =?utf-8?B?NW82ODgxM0Q0K3dJTllTczdtSDdqa29qa1JjbGI2cGMxa0xVSzdLM2laZjVF?=
 =?utf-8?B?eEVhUkRGb21HQUszY1JLWER4VlNML1hTL3VxeDlKUE1ZZ25oYmgxNHBhUy9w?=
 =?utf-8?B?UjFsVkErcU9qWnVyZEhZZUV0Vis1MnpHT0Q2TzdkMFBhWk1BRVY3a1NBRmNo?=
 =?utf-8?B?NHN2ZHV4amNIVzZHemw0b2lRaU5JaUV2NGcrclFVREZXcWcrS0dteDRoTGor?=
 =?utf-8?B?YWZPMURCL0RUWWQ2cWtOcWlYMHVsakxScnh1YVF5REVGTkJjSUM1c290S01v?=
 =?utf-8?B?aWlQN1RkTG1QN3owb2xtbU82bFhXVk1oc0tCTGw2UzRIZnNnNXVyVmdtcEx5?=
 =?utf-8?B?dENzYlFFa3A3VktMN0kvNEZIVnBvdFNHQnFJWHh6SGZ4bmpENGUxNnlaRUNr?=
 =?utf-8?B?ZERxK2ROOGE4N1VXOVpqbnU5Q0tic3V1NkM4Zkt5ajAxdGJ0b0pBbFIzekxq?=
 =?utf-8?B?NHVnbHBjSnpqOUZJejJqUDk3U0FlNktJWmdHWG9qZmdFa0JCYUFhdnJuSll3?=
 =?utf-8?B?T2xuZVMyY2hnKzVtNGVRWVJ4bmNXczdPR3RRZVRUVHZOVGxpd3RKUTBtbnpH?=
 =?utf-8?B?dFpTcmdacTcxL09iTlJtRnBlQXRVMVNrdTA2UEZZTnRBRHVEbDJqbUhwUXFs?=
 =?utf-8?B?bjBQSS9PWDNyVU45OUxzSzV0NjliTk9QUThwTTB2QUhWN0hVMjhaaFd0aUZ1?=
 =?utf-8?B?ZDNDOTZhbC9vQy9sNjNaYy8vRWZPOTJLTWsxbTNlcExsTldCbS92ZjgwSXZV?=
 =?utf-8?B?RjZRdEMvdTB4TmkxSVNQU2NyRVJCb0Yva1ZwcnRicGVoMFNLSm1JZGVsbDNC?=
 =?utf-8?B?ZkcrR0M2SUh6NWRTYmNYMTNidjFGWDkxUC8rakducitJaGg2UzFaOGNXV2FX?=
 =?utf-8?B?UlZHNGgvN0xXbEVoYjhxbUlzc2hXNzgxU0ZRUzYyclN1UnBVRUFVWnBWVlpp?=
 =?utf-8?B?RmZGSGhoMVhOUjJrVjgvdzhETW5DT2FFT2hYci9DZFlLQ1hGRU5xd0xrMElh?=
 =?utf-8?B?Z2NqVkIzL0Z6b3l0UHM4dnhvdllSby8rdDE2aTBCRHB6Ni9EZUVxR0JRQWlM?=
 =?utf-8?B?QUxKdTFBZkZKM1JOaUtaZTJkWTdtSFBJTGI1Uk9jMUg2cFhDbEpqc0pXVmhI?=
 =?utf-8?B?Y1MvaGpWLzJBTlp1dTVkK2pJSWxzanFDaUhRTTdLUGUxVUI3Qm0vdXZJSk9a?=
 =?utf-8?B?Q3ZKeVVSTVp6aHZjQWZ3aTN6ZDRSOElsYXpXYTRBVmF3dVpYbHNac21OM0Vl?=
 =?utf-8?B?eSswWnlqcWs4SDlaMVJWWW9ZS2djOUMveVl6d1hsSzVmSmVLL2hmdS9RcWwr?=
 =?utf-8?B?NnB5RXVDVlR2REFKNEU5a1oyN1ZuTWlLUkRwM01Sc1E5ZVE2YmsxZFZyMUl5?=
 =?utf-8?B?OXNvcy9XcFJJQTR0K2Zsb0tLSGY0ci9tOXFHZ1BMZzhlWDVpY25lb2l0MFFv?=
 =?utf-8?B?ZnYwVTZBdTM2aDZ2TytTSEVDcXFoczhLek0xZCsxdlFMODZSTmtIeVVCSjR5?=
 =?utf-8?B?SW8rWm5xNjBqQUVvSENYbHFzd013VVVuakZadlhyMlhuRHZrNndLbldYVWJD?=
 =?utf-8?B?Z1lJNzd4VGRwNlduSzR5QkZtRnVGNk9OcCtTeVJqM2UxU1NUWDliUEFGV2Fr?=
 =?utf-8?B?cGM2bmJSaVBUZWdlNHpqTXBFVlNOb1Q1ZUJ4ekc4bDZOQktWYW9xbWdCMCtT?=
 =?utf-8?B?VEhxT2Z4czcyMVBVaWF2eHE3ZzVGbGNhNjZhcnFzWW1NUk5XRGdtU0tNM1RZ?=
 =?utf-8?B?RjZwYjkyMjlNa1hUQ2VKWnQ0bzczZW8xUGxqWGlGMDQ5cnQzZjhScHVUOFoz?=
 =?utf-8?B?QVAzUGNTZWlDa0hHTkpuRk1RVmJtaVoyRnZNZVNQazUybmxVaUp4WGlrbjh4?=
 =?utf-8?B?eDJBOXBTQlNKaEY5TE1wVGt2NFNZRnZFR25GQjFkcmwwVEVaaytNMnF3YWIr?=
 =?utf-8?B?bHhUempoMkRSVHN6TWVQeFpma2EzWWh3dUY2cEdnMGl1VmFnd29weWMyMXBP?=
 =?utf-8?B?OEJtcTFMclA0anVxaTUvSUFMSzIzVzIvNldKT0wyRUp0SE1FMGxGbzlyUWdD?=
 =?utf-8?Q?9L58=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BCAA95723E783E4D80DEB4543407C9C8@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd9cb2eb-10a0-499b-77ce-08da7980adb3
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2022 20:58:00.2716
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w+B9QFt876lKol3B/Eeyty3rZyVeZS6N13u5vz9VCcjNL7xLHsTvg1FGZvAT43YJnkJ5/kGbHlIEzVFTZo6jqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2985
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-08_13,2022-08-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2208080091
X-Proofpoint-GUID: RLkCxT8-dma-NRiKkKQJgR59QRCRMBmB
X-Proofpoint-ORIG-GUID: RLkCxT8-dma-NRiKkKQJgR59QRCRMBmB
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

T24gOC8zLzIwMjIgMTo1MyBBTSwgSW5nbyBNb2xuYXIgd3JvdGU6DQo+IA0KPiAqIEphbmUgQ2h1
IDxqYW5lLmNodUBvcmFjbGUuY29tPiB3cm90ZToNCj4gDQo+PiBXaXRoIENvbW1pdCA3OTE3Zjlj
ZGI1MDMgKCJhY3BpL25maXQ6IHJlbHkgb24gbWNlLT5taXNjIHRvIGRldGVybWluZQ0KPiANCj4g
cy9Db21taXQvY29tbWl0DQoNCk1haW50YWluZXJzLA0KV291bGQgeW91IHByZWZlciBhIHY4LCBv
ciB0YWtlIGNhcmUgdGhlIGNvbW1lbnQgdXBvbiBhY2NlcHRpbmcgdGhlIHBhdGNoPw0KDQo+IA0K
Pj4gcG9pc29uIGdyYW51bGFyaXR5IikgdGhhdCBjaGFuZ2VkIG5maXRfaGFuZGxlX21jZSgpIGNh
bGxiYWNrIHRvIHJlcG9ydA0KPj4gYmFkcmFuZ2UgYWNjb3JkaW5nIHRvIDFVTEwgPDwgTUNJX01J
U0NfQUREUl9MU0IobWNlLT5taXNjKSwgaXQncyBiZWVuDQo+PiBkaXNjb3ZlcmVkIHRoYXQgdGhl
IG1jZS0+bWlzYyBMU0IgZmllbGQgaXMgMHgxMDAwIGJ5dGVzLCBoZW5jZSBpbmplY3RpbmcNCj4+
IDIgYmFjay10by1iYWNrIHBvaXNvbnMgYW5kIHRoZSBkcml2ZXIgZW5kcyB1cCBsb2dnaW5nIDgg
YmFkYmxvY2tzLA0KPj4gYmVjYXVzZSAweDEwMDAgYnl0ZXMgaXMgOCA1MTItYnl0ZS4NCj4+DQo+
PiBEYW4gV2lsbGlhbXMgbm90aWNlZCB0aGF0IGFwZWlfbWNlX3JlcG9ydF9tZW1fZXJyb3IoKSBo
YXJkY29kZQ0KPj4gdGhlIExTQiBmaWVsZCB0byBQQUdFX1NISUZUIGluc3RlYWQgb2YgY29uc3Vs
dGluZyB0aGUgaW5wdXQNCj4+IHN0cnVjdCBjcGVyX3NlY19tZW1fZXJyIHJlY29yZC4gIFNvIGNo
YW5nZSB0byByZWx5IG9uIGhhcmR3YXJlIHdoZW5ldmVyDQo+PiBzdXBwb3J0IGlzIGF2YWlsYWJs
ZS4NCj4+DQo+PiBMaW5rOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzdlZDUwZmQ4LTUyMWUt
Y2FkZS03N2IxLTczOGI4YmZiODUwMkBvcmFjbGUuY29tDQo+Pg0KPj4gUmV2aWV3ZWQtYnk6IERh
biBXaWxsaWFtcyA8ZGFuLmoud2lsbGlhbXNAaW50ZWwuY29tPg0KPj4gUmV2aWV3ZWQtYnk6IElu
Z28gTW9sbmFyIDxtaW5nb0BrZXJuZWwub3JnPg0KPj4gU2lnbmVkLW9mZi1ieTogSmFuZSBDaHUg
PGphbmUuY2h1QG9yYWNsZS5jb20+DQo+PiAtLS0NCj4+ICAgYXJjaC94ODYva2VybmVsL2NwdS9t
Y2UvYXBlaS5jIHwgMTMgKysrKysrKysrKysrLQ0KPj4gICAxIGZpbGUgY2hhbmdlZCwgMTIgaW5z
ZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9r
ZXJuZWwvY3B1L21jZS9hcGVpLmMgYi9hcmNoL3g4Ni9rZXJuZWwvY3B1L21jZS9hcGVpLmMNCj4+
IGluZGV4IDcxNzE5MjkxNWYyOC4uOGVkMzQxNzE0Njg2IDEwMDY0NA0KPj4gLS0tIGEvYXJjaC94
ODYva2VybmVsL2NwdS9tY2UvYXBlaS5jDQo+PiArKysgYi9hcmNoL3g4Ni9rZXJuZWwvY3B1L21j
ZS9hcGVpLmMNCj4+IEBAIC0yOSwxNSArMjksMjYgQEANCj4+ICAgdm9pZCBhcGVpX21jZV9yZXBv
cnRfbWVtX2Vycm9yKGludCBzZXZlcml0eSwgc3RydWN0IGNwZXJfc2VjX21lbV9lcnIgKm1lbV9l
cnIpDQo+PiAgIHsNCj4+ICAgCXN0cnVjdCBtY2UgbTsNCj4+ICsJaW50IGxzYjsNCj4+ICAgDQo+
PiAgIAlpZiAoIShtZW1fZXJyLT52YWxpZGF0aW9uX2JpdHMgJiBDUEVSX01FTV9WQUxJRF9QQSkp
DQo+PiAgIAkJcmV0dXJuOw0KPj4gICANCj4+ICsJLyoNCj4+ICsJICogRXZlbiBpZiB0aGUgLT52
YWxpZGF0aW9uX2JpdHMgYXJlIHNldCBmb3IgYWRkcmVzcyBtYXNrLA0KPj4gKwkgKiB0byBiZSBl
eHRyYSBzYWZlLCBjaGVjayBhbmQgcmVqZWN0IGFuIGVycm9yIHJhZGl1cyAnMCcsDQo+PiArCSAq
IGFuZCBmYWxsIGJhY2sgdG8gdGhlIGRlZmF1bHQgcGFnZSBzaXplLg0KPj4gKwkgKi8NCj4+ICsJ
aWYgKG1lbV9lcnItPnZhbGlkYXRpb25fYml0cyAmIENQRVJfTUVNX1ZBTElEX1BBX01BU0spDQo+
PiArCQlsc2IgPSBmaW5kX2ZpcnN0X2JpdCgodm9pZCAqKSZtZW1fZXJyLT5waHlzaWNhbF9hZGRy
X21hc2ssIFBBR0VfU0hJRlQpOw0KPj4gKwllbHNlDQo+PiArCQlsc2IgPSBQQUdFX1NISUZUOw0K
Pj4gKw0KPj4gICAJbWNlX3NldHVwKCZtKTsNCj4+ICAgCW0uYmFuayA9IC0xOw0KPj4gICAJLyog
RmFrZSBhIG1lbW9yeSByZWFkIGVycm9yIHdpdGggdW5rbm93biBjaGFubmVsICovDQo+PiAgIAlt
LnN0YXR1cyA9IE1DSV9TVEFUVVNfVkFMIHwgTUNJX1NUQVRVU19FTiB8IE1DSV9TVEFUVVNfQURE
UlYgfCBNQ0lfU1RBVFVTX01JU0NWIHwgMHg5ZjsNCj4+IC0JbS5taXNjID0gKE1DSV9NSVNDX0FE
RFJfUEhZUyA8PCA2KSB8IFBBR0VfU0hJRlQ7DQo+PiArCW0ubWlzYyA9IChNQ0lfTUlTQ19BRERS
X1BIWVMgPDwgNikgfCBsc2I7DQo+IA0KPiBMR1RNLg0KPiANCj4gSSBzdXBwb3NlIHRoaXMgd2Fu
dHMgdG8gZ28gdXBzdHJlYW0gdmlhIHRoZSB0cmVlIHRoZSBidWcgY2FtZSBmcm9tIChOVkRJTU0N
Cj4gdHJlZT8gQUNQSSB0cmVlPyksIG9yIHNob3VsZCB3ZSBwaWNrIGl0IHVwIGludG8gdGhlIHg4
NiB0cmVlPw0KDQpObyBpZGVhLiAgTWFpbnRhaW5lcnM/DQoNCnRoYW5rcyENCi1qYW5lDQoNCj4g
DQo+IFRoYW5rcywNCj4gDQo+IAlJbmdvDQoNCg==
