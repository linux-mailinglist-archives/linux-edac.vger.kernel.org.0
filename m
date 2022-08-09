Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49CF558DB07
	for <lists+linux-edac@lfdr.de>; Tue,  9 Aug 2022 17:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244950AbiHIPWA (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 9 Aug 2022 11:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244892AbiHIPVe (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 9 Aug 2022 11:21:34 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD098D122;
        Tue,  9 Aug 2022 08:21:33 -0700 (PDT)
Received: from pps.filterd (m0134423.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 279FKN35018823;
        Tue, 9 Aug 2022 15:21:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=TGujyUsiywVkkgHTCOPQVZbTqeuCq4bWpVLtEU5T9A0=;
 b=n1wzgG429cRIUHyhGK2gC9+k+3CIxeg8pFNsobVBbIpAmj3t5e1QbbBxeVGcpwu6wg5L
 keKHM72o63URT1SAICdfadVZ4RJyPgaDic3kw5yJuBDzsj41zDku1y5io08NLuzZm9Wb
 hg2r3Ug6bRdr3m1042TeBrx7xgGls8IcqtP5rYXb34vKoiTwXtRae8qkWzumokYo4+P6
 b0yg+AZleWl2v0/WWssyFt3geYD51uKhZX/J5Cb0pSUvmEcjucl7ubsWQjRn2acK8kcE
 zs2hZlRbo/0Dqs6H7mkX+lBkNar5KomETlymY0USeYMkiYPlXlz2g8CyLf7KRfAorEX7 5g== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3hut4p00kn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Aug 2022 15:21:14 +0000
Received: from p1wg14925.americas.hpqcorp.net (unknown [10.119.18.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 0A7B9E5545;
        Tue,  9 Aug 2022 14:57:29 +0000 (UTC)
Received: from p1wg14924.americas.hpqcorp.net (10.119.18.113) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 9 Aug 2022 02:57:27 -1200
Received: from P1WG14918.americas.hpqcorp.net (16.230.19.121) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Tue, 9 Aug 2022 02:57:27 -1200
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 9 Aug 2022 14:57:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UX6R+A1LHLEwLOxiNWBnr7x3H7D751H/K5SZWJkn0NeujxTvsE5ENIC/fQ15Ke37OOhgoTPrm6aDXITtaSr3B1WqyQ/yQ09utt+JxJxrSfo91YtleVaH4K+fR1jLA+2PyvSBZc5E7CW1X1smUXKIiQIWkJb5z+lAu87xIWG80B84BqmsTCFfGGBTeT8S9XS2Z7HNiu/JndWfnKetSLl4iFKTMlbI0TgRdXovb6pB3weWULtXxVzz3SJIDMIp0twcQP6n5Fg3ntAV3CkBmzJbMi04JezytoWKNe4ud7OgJ+KZ2MTQFpEYwUyfWd2feX1Ri5BryeIROYReAkQ2g1aE9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TGujyUsiywVkkgHTCOPQVZbTqeuCq4bWpVLtEU5T9A0=;
 b=CRbf9BeAfZ26UxbytK/UgCFcw8eeVH+INjOv8OkEJvxwraKFBLcjKoLnNd3egpfizuQ9nMOU4F41tkm1uDKcKnpFsrFmf1uNeM3KZDJjkHlbDiPXe9S1TeM4QVv0Tu8ldgtJtcrE9Szg12vcuC0Xrh3xNdI1HQDLD9FMmqETGFeeSJ29vdjopLa1QbpEenoyVBhb5KeOkJYaF1bG3740XMdTKqOTEJoVBJQMC44/4kwwtIW9LIIwgsTLgiG6s6Q8wRDtwQ0sjskeOyh0CJykZe/Iol5T69FVCQRwoFHhdt7tom5qzCemPdDEWU0mZcbX+BnWFOG+3HiceD4gVbk3vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:154::8)
 by MW4PR84MB1682.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1a5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.20; Tue, 9 Aug
 2022 14:57:26 +0000
Received: from PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::dcac:1265:7a54:ee2d]) by PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::dcac:1265:7a54:ee2d%6]) with mapi id 15.20.5504.020; Tue, 9 Aug 2022
 14:57:25 +0000
From:   "Kani, Toshi" <toshi.kani@hpe.com>
To:     Justin He <Justin.He@arm.com>, Borislav Petkov <bp@alien8.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>
CC:     Len Brown <lenb@kernel.org>, James Morse <James.Morse@arm.com>,
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
Thread-Index: AQHYq1YbHdpOiV0alEuUJHkPzB7Jbq2lceiAgADmrYCAAE+p0A==
Date:   Tue, 9 Aug 2022 14:57:25 +0000
Message-ID: <PH7PR84MB1838B57BCEBEF1D8E02CD12D82629@PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM>
References: <20220805023200.154634-1-justin.he@arm.com>
 <CAJZ5v0gUbKYaxRcZsYO6eq7vLgKdgfdLdoL_Hzmd6r-JczkVPg@mail.gmail.com>
 <YvFX9vTilqMpsF9u@zn.tnic>
 <PH7PR84MB1838379B8C2DF488DE729A9182639@PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM>
 <DBBPR08MB4538A3F6A2F63B3AC8223FA6F7629@DBBPR08MB4538.eurprd08.prod.outlook.com>
In-Reply-To: <DBBPR08MB4538A3F6A2F63B3AC8223FA6F7629@DBBPR08MB4538.eurprd08.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7973926b-1ad9-4137-5c18-08da7a177902
x-ms-traffictypediagnostic: MW4PR84MB1682:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fYvzb3eSoyRRVri6ieh2q3jXbTKPQAdkIdJk/RUAuMziYRW2lXdmi2L8BpvD/EqNmSMpDjhF+an0lOyLQKo3gsaJBz58fIe7v5VKXldxLpmeZPw2sGXFTpuCMrRMQvKHeiMj08VTQ9p6ebqSj2ot1TW0UUSSWCN+txl/szUhx5A5OZ8Oa3RiSKXBdNYIKudgYsFC7ybqrT3+DVVBz8cuuYBlLRAMXFpZrpinRLMfWP80tY37IDd7GyPZdIebU/riQrxVtwvFAN2M464+c/h7QVe8E0zFGJuLvLXLFLmWBNd+49dlGzlxqlbjyBIO2eqyKzMaUBR6XR18qGk5B4nyXqfit5uWCgefLhC3FN9G1GlOU0vxz59GpC9674CkwZWbAXThkDN/8yftaBywdwlyJsKkkEA4DacE8jUNTAiW+hAQ3eJ1+7/ddtZ+0bB57b4QOIUmYnlWBMfXuvERUaLG1RUTSJGtbLRS8WdWMmFjWwTzQ+J/i2E7TY4CKVo9FSWcXxIdoyxQy9lXwZb6MDGpF9oL4Bgl0KjVidOqxp0ojIHv7wQOL6lw3I9NNfUaHh5+vYIfPZM4tM43igYqrpph2rug9sxzBIK1hJuu92MkMUSdcgDZaZRGYB+t6t0wdlRvdidSI+kePMaY1Z5afoDtDJOnyvcotbcYYLtbaaDVgFESItcMyAODpiWES3GjD0Fdd4wZ/jUQPkcJq3IZDRK5dcZHWRBq/lHXVDR2gBTBxURTRniOHyJUk8/7mMF+IN/ISCf4Fnt8UHqbQEWY88NG/p9zUMRYUKFXbpzQz9msC3NSb9jKaUfrEoyuYEbbFh5T
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(366004)(136003)(39860400002)(396003)(376002)(346002)(6506007)(7696005)(38100700002)(2906002)(38070700005)(41300700001)(82960400001)(53546011)(4744005)(33656002)(9686003)(55016003)(186003)(26005)(122000001)(316002)(76116006)(110136005)(54906003)(66446008)(4326008)(66476007)(66556008)(8676002)(64756008)(66946007)(71200400001)(52536014)(8936002)(86362001)(7416002)(5660300002)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UVdNL0Y3bjB2N3MwTGowUWNOV2dTYTVMbklFaUxEdzAwVmNqNkV4LzJQbW1C?=
 =?utf-8?B?WGNrMzJ3dzY0U1lKVWNuVWJSTmtMK1BVNVJWbm1kSURYeTlkK0tNdGNYWmhD?=
 =?utf-8?B?UElBU2l4bmpKQmYrVHdTWlpxRFM3Snd6eXdhNTFTN0VZRkFqVFN6bWN4TzVn?=
 =?utf-8?B?ZGhPdDRLdC91U2U3OTVTanhxdkFUL2ZTS2VMWnpVU1htRnV3Y1hDcVY5Z2FE?=
 =?utf-8?B?NlpxM01pdDB1bHdnS0srQ1F5Q1hEeE5tcDQ0Qk1uSkdRQ2dtc1RQRUoyYXZC?=
 =?utf-8?B?NUVwc2hsdnpKelRTWjhmNnZubkRnQ2psRENFc24rVG1FTnl0NEtWR1h1Y1c5?=
 =?utf-8?B?bFR0a1VmekJrKy9naThhdFdhd2hCWFpKZmkwYkZMenhLOXNwMFVtZGJnWE9S?=
 =?utf-8?B?bUloc0ZYdTJWbWhpZkhRYnFXRHBXdHhzbUVZVEN4eHdwQ1FQWHFESFhBdXBv?=
 =?utf-8?B?Y1hlUXRaSEh6VXdWTUh5cVJJNHplbzA0UEUyQlJBR1ZtTW45M2V5QzVnZUUx?=
 =?utf-8?B?MVd5ZW91RVJlbjRFdHVyTWlyTVRJelY5WEM0Y0llb0c1RXhjU3kxUGwyTTRr?=
 =?utf-8?B?bzA4d3pCeGRsM2Q2UWxmWHZKTzFSa2RRTXlDTkNPVkI4K1pqSXlGUXFWc2t6?=
 =?utf-8?B?a0R1OGVvSzdta0NSVnJLakErd240a3c2ZTFianphK3pPNlE0QTVXOTRvQysz?=
 =?utf-8?B?WjFPdnZSM05POTJjYWR3Y0xmVk16SS9VbENDWllhWjVvVmxCRzdPMHd0bTdh?=
 =?utf-8?B?S0JGMGZtRjJnYkFWWjUvOTZVRTY0UjczYzg3TXlpcVBGQW5SbksyQmlHck80?=
 =?utf-8?B?Qm9Qb0x0MDk4RjJZRHBDWjdLWEdQUGNyOEtpY3pQajk0ZlZybzU0cDJNMm9t?=
 =?utf-8?B?akExLysyZ0N0SFF6RnZObDBlRnRQWDYxQzJRR2JNMSt6ZnEyNlFMdWxwNVVD?=
 =?utf-8?B?dDNBWmJaU3ZaQWFxSTVXbkdNV0xTblhBTEhOaXY4Mk1YU1JjdWZOMFg0b0VY?=
 =?utf-8?B?RDgvUG5aSmsvUSt6eHZld3RUeFNBUlNxdDZ5Q1VJcnlqcWpaanpOa1I1Nmhm?=
 =?utf-8?B?Nm1RR0taSnRCUDZyeWdIQmVuSWk0dDZNUkxBL2RtVE9BU2k4K0RFU2lWMk81?=
 =?utf-8?B?Mmx1eGRkMGdkSXhSdUd0cUQ4TEhWUU54YW9CKzNtWGQ5SFFoWVVJZzFld3NP?=
 =?utf-8?B?Y0IyZlJDc09VQ1lYT3BmWlovVUZLVVJSeWs0N01WWGllUHZuVnJSZ0FDVW9l?=
 =?utf-8?B?OFU4T1VTQldRQVNUM09HWVRucEJ6Z29CdkJSU1F6VTA5eDdsd0JhL3dvNHFQ?=
 =?utf-8?B?bW5TWWo2dno2SXd1SVRYakxMK1h1Y1dRQ2JxM0RzQ0h1aW5sSFFQYysrbFlD?=
 =?utf-8?B?NWlKUGdCSFdwOWZmem5lMUVkQXBwNkVDdnEwMHU4NHBKc2Z5engxTzVBZVhC?=
 =?utf-8?B?RVdsbWYvTWg3QkN3Q2pEYTcrV2d0Y1VUcXpxb3JibGZhNnp3dWo3VGNIdUJv?=
 =?utf-8?B?a2kxc0lNUm5aZ3FpbHFVNlhlS2dtanhUNHNpY09hYkIzTGFYUEFxd0tRSG5s?=
 =?utf-8?B?eVQ3YnhZZkdhemkzSkp2ZmdPL2tVdXQybmdybERGR25qUGtZRmYvRDBFM0ZV?=
 =?utf-8?B?NmEzVWFsTkVNQ0NhSS8yZkxUcWVGbkorZmlpblJVTjd4Z2tFbjBPMWpDa0NE?=
 =?utf-8?B?RUgwRlB4WEFBUXVFUS90OE55bVJ4aythTWkxc1Q1Zktwb29xRGo5TjhQTmgr?=
 =?utf-8?B?aVN0RmxYckRzZ0c3alYzejFacEFTMkFyL1FUOVFTNVU1cnZPZm5mdEpBVURF?=
 =?utf-8?B?RUx0emtLWURyV1ZURTVmOXhZY1c1UHExaWRoWEF6aWFWaE1CUzc5RTJhZy9Z?=
 =?utf-8?B?RGRpNjhxVC9vMFhkcktRbDlreFNLa2p2REpHaGRrRzNrdklDTUcxZEtHb0lQ?=
 =?utf-8?B?cWdVWVZsVWFFVzRzSjRNaXFrRTRoQmgrZkFhN21PbVlCRUZSamRmWHVLUDk0?=
 =?utf-8?B?OW8wVm9PZ1UyeUZYQ0JXRi9EU1R3aXBYWVAxM2JCd2MzZnlXeGpFRXh3U0dZ?=
 =?utf-8?B?NGZjVGpDOEJDSE9NN2hKK2ZjY1YveXdlVXFQU1dJY3Y4TWp3Q1hTeHU4UVow?=
 =?utf-8?Q?G1Izk+FoyTeYC1YJqO8UaNCxD?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 7973926b-1ad9-4137-5c18-08da7a177902
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2022 14:57:25.9224
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LJ1GFyxP1rjzvKRKyZ263ZoJP5004xgmBga5h2DRYvct9Ws9dh//AxxurKNQdaWvu2lfkk5aSPkEVKnNJzpUBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR84MB1682
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: cDBs_fe9yLqWwEZ_RjRTrdqjAyd2K4X2
X-Proofpoint-ORIG-GUID: cDBs_fe9yLqWwEZ_RjRTrdqjAyd2K4X2
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-09_03,2022-08-09_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 impostorscore=0 suspectscore=0 mlxlogscore=999
 malwarescore=0 lowpriorityscore=0 mlxscore=0 adultscore=0 phishscore=0
 bulkscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2208090065
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

T24gVHVlc2RheSwgQXVndXN0IDksIDIwMjIgNDowNiBBTSwgSnVzdGluIEhlIHdyb3RlOg0KPiA+
IGdoZXNfZWRhY19pbml0KCkgaXMgY2FsbGVkIGZyb20gdGhlIG5vcm1hbCBtb2R1bGUgaW5pdCBw
YXRoLCBlLmcuLA0KPiA+IG1vZHVsZV9pbml0KCkuDQo+IFRoYW5rcyBmb3IgdGhlIHN1Z2dlc3Rp
b24sIG9uZSBnYXAgaXMgdGhhdCB1bmRlciBtb2R1bGVfaW5pdCBwYXRoLCBob3cgY2FuDQo+IHdl
IHBhc3MgdGhlIDJuZCBwYXJhbWV0ZXIgb2YgZ2hlc19lZGFjX3JlZ2lzdGVyIChzdHJ1Y3QgZGV2
aWNlICpkZXYpIHRvDQo+IHRoZSBuZXcgKiBnaGVzX2VkYWNfaW5pdCgpPw0KPiANCj4gSUlVQywg
dGhlIHBhcmFtZXRlciBvZiBhbnkgZnVuY3Rpb25zIHVuZGVyIG1vZHVsZV9pbml0KCkgcGF0aCBz
aG91bGQgYmUNCj4gdm9pZC4NCg0KU2luY2Ugc2ltcGxlciB2ZXJzaW9uIG9mIGdoZXNfZWRhY19y
ZWdpc3RlcigpIGlzIHN0aWxsIGNhbGxlZCB3aXRoIA0KdGhlIHBhcmFtZXRlcnMgZmlyc3QsIGl0
IGNhbiBzYXZlICpkZXYgdG8gYSBnaGVzX2VkYWMgc3RydWN0dXJlIGZvcg0KZ2hlc19lZGFjX2lu
aXQoKSB0byB1c2UuDQoNClRvc2hpDQoNCg0K
