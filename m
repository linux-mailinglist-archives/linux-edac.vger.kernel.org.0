Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E846C58CF91
	for <lists+linux-edac@lfdr.de>; Mon,  8 Aug 2022 23:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244138AbiHHVTC (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 8 Aug 2022 17:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238069AbiHHVTA (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 8 Aug 2022 17:19:00 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D10BB18B09;
        Mon,  8 Aug 2022 14:18:59 -0700 (PDT)
Received: from pps.filterd (m0150244.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 278LCS8e001732;
        Mon, 8 Aug 2022 21:18:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=Q2QcejdPkmEIU2e0E2+Ts4nEai3PHXjffqXmgfYtaY0=;
 b=cfmeyZa6KJARhb+Bf8D7NOASBTI4cL/ZKu8Jp5jHCA+RDDevvqp6BI3lwlIlM0za9awq
 TWxRXWtbGYtjhJQdO3PaD77p4SBFjMn4l47yxrJ9dRYCI6BpIVVMxUZZrW/vS1mzihj5
 PQRxIPg+PSsHQPWkqxu2CVDNFUqvy1TweeOU2jy3uin9RFBmzDzAkVjZpmx5tUDbai74
 lUnXGSFbj1nxJiG1AWZP8kvNAbq3UlGju6sGab037ASluRxeMMbUSKcarFDm6HCLnz/k
 xJMtXGCjpdiQPblRRBdBEo/0Q/XinF4BZeIKbilQUkHBsXrQimi9xmMTeMZUzKHnG8fT xQ== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3hua2d8grd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Aug 2022 21:18:39 +0000
Received: from p1wg14924.americas.hpqcorp.net (unknown [10.119.18.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id B732482021D;
        Mon,  8 Aug 2022 21:12:30 +0000 (UTC)
Received: from p1wg14928.americas.hpqcorp.net (10.119.18.116) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Mon, 8 Aug 2022 09:11:55 -1200
Received: from p1wg14923.americas.hpqcorp.net (10.119.18.111) by
 p1wg14928.americas.hpqcorp.net (10.119.18.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Mon, 8 Aug 2022 09:11:54 -1200
Received: from p1wg14919.americas.hpqcorp.net (16.230.19.122) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Mon, 8 Aug 2022 09:11:54 -1200
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Mon, 8 Aug 2022 09:11:54 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Js0npqB5KY12TuudG71HPbt9m7MRLqNRVU4bSZ6faj9qO0DqJqOiTiPjXjGfTAPZ1E1dhlbGfLifMmHJz96ZpItiSHF8vjUniABU8BemhGVV9SuKY/Ma1GSFjYcyXrtlNZnap4Y+JmwG4sl/uzvBFDDbGP1VwLPH0E9fSMmmQM8o/1bQ3yx/7/2iE2vH08OdiJVVa4MpwOASzYwaBQedhkPldj1INu3U/ZwUJkU86RhbUDQNatCWwCBHYuOCZvJtmLspIBAZWilimcdlGWb7aaubedLZpyDn1si3O0GB2vrN1NRkkLjX+UKc0SOSWCDVAdfXxP+VTDtlnrCR4i3RDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q2QcejdPkmEIU2e0E2+Ts4nEai3PHXjffqXmgfYtaY0=;
 b=BT3aUDQkhDpD4w9KdEiPYfCHxe1zjeaDLr4ajgeVyofUCD2ch0c3lP51I52INnAUkSw1NLcZD/AzdZa6NbvdD6JzhG88kKPq9t4p8hpbzTk6PqK7oRGELuWKBSH55tIQjEfJ3/02FVnF9h7IM4JB+xv3txqzLeLW5ZPEY/l7N2l9WKeZA8kK9A41XoZef/7z/SzmeFnNMGtxG/Kv4fVPlkXV9afzqcjfOFm806sm8HZvrGBkb/aLGPILMPgXw94JelOvLBeKB70kryXyoDfdje1XZvSvVkPGAngf4oZVSQ42vWV9nLi45Z0cyUBXDaVuT5CJLe/zEY82ZpHUbOLJYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:154::8)
 by MW5PR84MB1354.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1c0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.20; Mon, 8 Aug
 2022 21:11:52 +0000
Received: from PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::dcac:1265:7a54:ee2d]) by PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::dcac:1265:7a54:ee2d%6]) with mapi id 15.20.5504.020; Mon, 8 Aug 2022
 21:11:52 +0000
From:   "Kani, Toshi" <toshi.kani@hpe.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Jia He <justin.he@arm.com>, "Len Brown" <lenb@kernel.org>,
        James Morse <james.morse@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Robert Richter" <rric@kernel.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        "Jarkko Sakkinen" <jarkko@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:EDAC-CORE" <linux-edac@vger.kernel.org>
Subject: RE: [PATCH] ACPI: APEI: move edac_init ahead of ghes platform drv
 register
Thread-Topic: [PATCH] ACPI: APEI: move edac_init ahead of ghes platform drv
 register
Thread-Index: AQHYq1YbHdpOiV0alEuUJHkPzB7Jbq2lceiAgAAKR4CAAADVoA==
Date:   Mon, 8 Aug 2022 21:11:52 +0000
Message-ID: <PH7PR84MB1838492812F5ABAA4BB54D9982639@PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM>
References: <20220805023200.154634-1-justin.he@arm.com>
 <CAJZ5v0gUbKYaxRcZsYO6eq7vLgKdgfdLdoL_Hzmd6r-JczkVPg@mail.gmail.com>
 <YvFX9vTilqMpsF9u@zn.tnic>
 <PH7PR84MB1838379B8C2DF488DE729A9182639@PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM>
 <YvF4p01WJGGUwIJC@zn.tnic>
In-Reply-To: <YvF4p01WJGGUwIJC@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c885fb77-7540-41c6-82ca-08da79829db6
x-ms-traffictypediagnostic: MW5PR84MB1354:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JIZ/uRE8tzG65xwy454cDndhYh6jePTewiwoQ7Jxg062etiTsVNiqkYlizLsuKmYj1Cnivvb/T56SBlfQ/t7FnKQQSB4Gga+1NBXjDiQVJPvMs46i5G098gSOsPoES04mAis2DM6vt46Yk7DFEldnZC/yr3NMNUorls85P5xWgWHwYPJjBavCqPPLfI92lL5agzVh1/gIvSOZr2MJZhQnv6Khu/GksFEQGhdlWIIsPV3KylgBDwclYmgb8wviaaSMQZBEqh95taMewazllm49bEtGeOw6oxFWLGIa60UFIzCdm7vT3HEOgGT7DdvqIOtEQrOq2pyw8TscKF/7oX3nR77JwPH9MsrGBV5WJSgkYGyRNexj1tWkYxYQ0D6D5kd9rU8w1FZzfOJ67tSfbWHlehKX9ym0fR/SpfnzPhhRbbv9/DnKQVSWeNqTWyaOwviSlTYMtOhMFXzp/h5fWqtA7EpUTyXCJB+glVXDO73bYtle77x5p4cMkkBdlSrfWO+drGsSfHEh/GkNuyMOj21SAxECPNQjbp4WFCuRSs3MbX9d7gNeGih2CeUKI1dnh9yjzO2nj/plBaPxFBkLoCUTzLiYKQo4HODdOU9A++GkVnzNG1Fm5cTEege/j7dKl0Psfwr8T/WCTh0yBl/AtYDVXxHPwQaEZG676UybnnLec02DBcKp+rIOSF4uqkwAa9o53CwlyQtHqQZqrk07yGp/m/nxRyxhm9PDyP9gONQAbtHTkPycQCK2baICR1r3zsDRjFTnET9jkSLdMAw96O6TzuSETFXsqIkYpqF5sCWSrk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(136003)(39860400002)(396003)(346002)(366004)(376002)(8936002)(52536014)(8676002)(66556008)(66446008)(66476007)(64756008)(86362001)(122000001)(4326008)(66946007)(76116006)(4744005)(71200400001)(186003)(55016003)(316002)(7416002)(54906003)(6916009)(33656002)(82960400001)(9686003)(26005)(38070700005)(53546011)(41300700001)(5660300002)(478600001)(7696005)(6506007)(2906002)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NWxiS1lpMUNmNFJFaVVMZlp2TmY0ZHZTb3hSUlgza0YvcnB6bkloU0ovLzA3?=
 =?utf-8?B?eW53QXpiSHdVcFg5d2RKRWFTZHV0OEtQZUpZcGR0cldtOFJMTktnVGEvT0lu?=
 =?utf-8?B?b0hkY0daL3YrVlRUT2FVWDZvRVg4bzIyVDczTWJ5Yk1rc1VVbDRhSkRCcUFn?=
 =?utf-8?B?VHYwWTZCVDhqWFc5STZXV3Z6dGFQZjhmTGRJd2wxcWhiUkRYMG1Ubmd1L2xr?=
 =?utf-8?B?SmNQSXAxQ1FseFBuM2YyTXJjM3RTT053dHoxemZDandxa1R0bWQ3RXdjenRG?=
 =?utf-8?B?eWZWd3R4NG9acGxsM2VKeFU2c3FLSytndkFPUFJFSHhsVDZLQTlMbmxxOWhC?=
 =?utf-8?B?QUgySTdOUitvYkZmTW0rT0lHY1VsaHV0OFEwTDVxY0oyM3RTOWJDaVJMZ21I?=
 =?utf-8?B?ODVZUUxCdWNuelk5MC9RcWhOdlRXbGVkb2x4TXJLdGlVSlBkM0kwK1hmbTFG?=
 =?utf-8?B?VVdlNmxjWjR5aW9yWktXVUxMK0I3R1RxOGxhd0ZlZysvS2tYOGdmbG5RRzNa?=
 =?utf-8?B?eG1XUGJIRSt2N3VUa0tNRkI3eUs5aXNraktVYjlFcUNkdXRuUWkvRnVPUjVN?=
 =?utf-8?B?MDc2UEt2cjZxcVBZRGpMa3VEVGhUNVFob2xSVUN2QzdHNTJYRFRPU2V2Vk14?=
 =?utf-8?B?UXBYbFFweEVBVjBSNk9wNUVRMnlvWDRTMlRha0toNW9hWm5ub29uN2hVMUxH?=
 =?utf-8?B?VytOUkZaTzNzOTRQNDNHSnRqNEpSWk1DTWs1WmhubHBTei80K2F4eXFJb3FJ?=
 =?utf-8?B?MUpzd0tBUFVTeUZJb1NJRThhYWpYT2VDWEg3UVl2TlZkY1J1aUc4bGZ5d0wr?=
 =?utf-8?B?YjNyK0V3d3ZXNnR6UnZSSFVuRGJ3aUp3RFB3bXJuRnRMM3Z5OTRtaUZPbDZC?=
 =?utf-8?B?Z1FibkRidlJXRHNFS3lpSG05WHhDZCtKRFlVajFsT1RoRnNZUnZqUVBZZXlW?=
 =?utf-8?B?NDUzM3pCNW9IaFZQb3E5cTRkc0hVTzdmaGo3WFg3dEJueCtGY1cxdjU5QU9O?=
 =?utf-8?B?NUFlMW1KbGdEQmZqMkRZMjB5OUJwSmdHWHlaQjlZcHJlaCtsSkdXYWFwT0RE?=
 =?utf-8?B?L2lYR0FtSkRpUEY1OEl0ZlpCOXIvWERHbDdOM3Fac21xYlV5ekQ1c0NXN08x?=
 =?utf-8?B?U1lFdmRxb3ZFTmh0NnExU0doNzRHbW95aVc5UzEzUnR1N0o0M2E2NERoSnNx?=
 =?utf-8?B?T1AySHhMZUY5c3g3QVdFRVByR3JYSDF3MUgxd0UrNjFxNjZKeFVONlk2Y3pI?=
 =?utf-8?B?ODJJM1lnY2FkcU5wbDNxaDhrb0V5VGRXa3BqelpNVzB0R1pTN1N2aTY0RWhk?=
 =?utf-8?B?VUwzRXNPek1rSVc2V0dCSktkdmNqc3RkY1ZZRDBDT2Z1YzllR2MzdWJ5YklY?=
 =?utf-8?B?MGI0Nk80L3ZNYkdGcWNJRkt6VnNYd05RNjB1MzdtaTFLSGd5OG01ckZKaFlq?=
 =?utf-8?B?M0dyN2srY25XR0xkUURDYisrYU1NbFRWZk9CWTBSajh0UTh0elczRXhxVjhm?=
 =?utf-8?B?NU56OGtFTGNxNlBtRXZvNTJscTNWNGdjaFo2eWFWQ2dXWDJodVJLUFl3Zk5T?=
 =?utf-8?B?S0Rvd2FObnFCa3NIVWg0bERZVm1RakpadDBwSkorK1RjcnlpTjFTMW5jcGhZ?=
 =?utf-8?B?YUM5NXVrM2xUM2pXbWJ3dlZXeWtBcHdUZk1GWnBJSy9MZ1dRMHFjZ0pEMkhs?=
 =?utf-8?B?SEk1a2lSc2tZd044ZFlWSUxsaEZsNS94WlNHb3RMLzd2cVBsYWxwdkZVTERx?=
 =?utf-8?B?RzBBMFh2MEtGUGU2RW44OEJJYkZ5N2lPV2thb05DcXptRFNVSTh6eTlZVE84?=
 =?utf-8?B?WnlmR05CV1ZnYUkzY2Ixb0cwcXdSQkIreTREZHNhaC9kNFVrY2kxeTRic01J?=
 =?utf-8?B?VUs2dzZwNTFxV3F5MVJYVDFBK1AwWWN1SFN5ODQ1Q2xqMGFBL3cvd0pSa0di?=
 =?utf-8?B?UUdGUUNRZ1JnKzBlMnNCRjZxNFRvck8yaTZrZm9kcVNkNEw0S0pBTDV4OHNM?=
 =?utf-8?B?UHpXNGkxL2QzQjRQNThxY2I3ZGlaU2RsWjZxemZFbzV1dGxIOG96cVBKRk05?=
 =?utf-8?B?REtBbkdFK3dyV0xTcDVlQWxVT3BiN2p3b2k5a2cxNkxLTE9BajBSYlZTaFZa?=
 =?utf-8?Q?VcyahRWRB+7+bfUqbpLNC2xGu?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c885fb77-7540-41c6-82ca-08da79829db6
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2022 21:11:52.4414
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hUAc3APHT0CoEvnMJ0GiIdgxPb6tVXWbon22liRb28VJ1+I4N56hnexYx91r8YoQC/74zgW4fXIcXn8HwzCFBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR84MB1354
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: TXoR1h7xessqaksyVp3qEbYkR1qSF9Jy
X-Proofpoint-GUID: TXoR1h7xessqaksyVp3qEbYkR1qSF9Jy
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-08_13,2022-08-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 bulkscore=0
 mlxlogscore=724 suspectscore=0 mlxscore=0 spamscore=0 clxscore=1015
 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2206140000 definitions=main-2208080092
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

T24gTW9uZGF5LCBBdWd1c3QgOCwgMjAyMiAyOjU3IFBNLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6
DQo+IE9uIE1vbiwgQXVnIDA4LCAyMDIyIGF0IDA4OjQwOjE4UE0gKzAwMDAsIEthbmksIFRvc2hp
IHdyb3RlOg0KPiA+IFRoaXMgYWxsb3dzIGdoZXNfZWRhY19yZWdpc3RlcigpIHRvIHJ1biBiZWZv
cmUgZWRhY19pbml0KCksIGFuZCBzZXRzDQo+ID4gZWRhY19tY19vd25lciB0byBwcmV2ZW50IGNo
aXBzZXQtc3BlY2lmaWMgZWRhYyBkcml2ZXINCj4gDQo+IFNvIHRoaXMgaXMgdGhlIGltcG9ydGFu
dCBwYXJ0OiBob3cgZG9lcyBpdCBnZXQgZGVjaWRlZCB3aGljaCBFREFDIGRyaXZlcg0KPiB0byBs
b2FkPyBUaGUgY2hpcHNldC1zcGVjaWZpYyBvbmUgb3IgdGhlIEZXIGdsdWUgb25lPw0KPiANCj4g
VXNlciwgcG9saWN5LCBldGM/DQoNCldoaWNoZXZlciBsb2FkZWQgZmlyc3Qgd2lucy4NCg0KQ2hp
cHNldC1zcGVjaWZpYyBvbmUgY2hlY2tzIHdpdGggY2hpcHNldCBJRHMgYnV0IGRvZXMgbm90IGNo
ZWNrIHdpdGggR0hFUy4gIA0KSGVuY2UsIGdoZXNfZWRhY19yZWdpc3RlcigpIG5lZWRzIHRvIHJ1
biBiZWZvcmUgY2hpcHNldC1zcGVjaWZpYyBvbmUuDQoNClRvc2hpDQo=
