Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7A858DD44
	for <lists+linux-edac@lfdr.de>; Tue,  9 Aug 2022 19:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245419AbiHIRgc (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 9 Aug 2022 13:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245439AbiHIRga (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 9 Aug 2022 13:36:30 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD45C21829;
        Tue,  9 Aug 2022 10:36:29 -0700 (PDT)
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 279HOJ9x003384;
        Tue, 9 Aug 2022 17:36:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=8tZKTRC0TGqsw1r6zCuvSX32lUFcKjDtx4WRRjk6sOM=;
 b=EuCmYGLHpB3QK01bpFVDjxSLfJOZ3/P+FSJNizJiMAaBu8Cw9BTND+BWILZuiWJKBO6T
 2fs6XeMYuoYJbCtWXwuYBUsYq7RomlNEsYFs11oONJExrERf0Zo46TaWpoKWB3WQZJ/b
 pLBgcSVwdJPK36XY9nxLiGhK59vjJygZ//Z2vYTGYdda+j2+PypfNaKaHJHD+tbEIHuR
 jZYWK4LHLSlhf75LbHluLpy+1eHJp5QhoarZ1K50uzfP6jMFBwXNsRprNZ329+Knwlif
 DJSHjIvFLbyjBb3cpW4lVVGOX5HQYEMxs+xTAj+WCmb1GcXYbjoprXL97/tFLjkULWnf JQ== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3huuxh839h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Aug 2022 17:36:17 +0000
Received: from p1wg14924.americas.hpqcorp.net (unknown [10.119.18.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 31EB1800E87;
        Tue,  9 Aug 2022 17:36:16 +0000 (UTC)
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 9 Aug 2022 05:36:15 -1200
Received: from p1wg14920.americas.hpqcorp.net (16.230.19.123) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Tue, 9 Aug 2022 05:36:15 -1200
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.123) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 9 Aug 2022 05:36:15 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BXQYKNC0BeSYnl0P+9iQxPHIhPOO0I/exzLmLwP/DOzxzm3JcnvLcFr616Wca48s75gGkijcwSqPsfXz4W9t2jDMOe6mP95EoqYVzC42tcndw0FeQ+AKvCgSlxpzrSJ+K/w5I9RlVxO5BvwZpECpaVMyzicqRcmiJFRjqXdlRwqJgMKJWnkUCoiF45aG0UuKZbl6sQ7phjcX0CTvitwFPnvphfCQQSxAZ5Aj761VyJJZW04Fses0ML/o4nQM+/et9vx3EERlbuIJG1A8gYjUW1yxmBsbvywUwRNruB7hySfV5fpdAlCcKBKu9EG+1fU7Q1Cs98de1TtWIWCJNNC5KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8tZKTRC0TGqsw1r6zCuvSX32lUFcKjDtx4WRRjk6sOM=;
 b=gcow9NLocnHCcGZSOKxn6Z/JYakOkqYRd4qrry2qO4VIpfgnniMVnDb+gZYGiOPdLy11mxKZ8IHbnucbVD6NxnVnCDDmUV79xZYCdf7+etOeaU3zZ+UI651idbrPt2O+0qQ4kKzVDJThW3Dcu4tdqEyolITSBM400h0GcyXRBq40qWwXSrLD0lOvjKVbyxsGe3itujHakF0wHR4myKYb7jfUmLiW2vAQ9XxIhiGaL9qMcxGhUv7gPPysmzGVVL1kZknLJuQLe8PZN9Sk7Blt+pcJgS6ZC/dkwUpXzfTwmaueopqZxv1cOLO2XviXjfdmyfVnK869EvEVS53jNGqNSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:154::8)
 by IA1PR84MB3108.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:208:3e8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.21; Tue, 9 Aug
 2022 17:36:12 +0000
Received: from PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::dcac:1265:7a54:ee2d]) by PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::dcac:1265:7a54:ee2d%6]) with mapi id 15.20.5504.020; Tue, 9 Aug 2022
 17:36:12 +0000
From:   "Kani, Toshi" <toshi.kani@hpe.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Justin He <Justin.He@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, James Morse <James.Morse@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Robert Richter" <rric@kernel.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        "Jarkko Sakkinen" <jarkko@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:EDAC-CORE" <linux-edac@vger.kernel.org>
Subject: =?utf-8?B?UkU6IOWbnuWkjTogW1BBVENIXSBBQ1BJOiBBUEVJOiBtb3ZlIGVkYWNfaW5p?=
 =?utf-8?Q?t_ahead_of_ghes_platform_drv_register?=
Thread-Topic: =?utf-8?B?5Zue5aSNOiBbUEFUQ0hdIEFDUEk6IEFQRUk6IG1vdmUgZWRhY19pbml0IGFo?=
 =?utf-8?Q?ead_of_ghes_platform_drv_register?=
Thread-Index: AQHYq1YbHdpOiV0alEuUJHkPzB7Jbq2lceiAgAAKR4CAAADVoIAABbmAgAACeaCAAKrLgIAAHP6AgAAfFoCAAC4DUIAAFJuAgAADHnCAAB2pAIAAAtUQ
Date:   Tue, 9 Aug 2022 17:36:12 +0000
Message-ID: <PH7PR84MB18387658964C9BEC71925C2B82629@PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM>
References: <YvF4p01WJGGUwIJC@zn.tnic>
 <PH7PR84MB1838492812F5ABAA4BB54D9982639@PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM>
 <YvF+J/dfyOEVSbSQ@zn.tnic>
 <PH7PR84MB1838BF4F8B56EF1E24FCF1DC82639@PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM>
 <YvIPf/m3hU46S9Ik@zn.tnic>
 <DBBPR08MB4538A5C080B09A96A77CCDA9F7629@DBBPR08MB4538.eurprd08.prod.outlook.com>
 <YvJB5cxSldpigw1g@zn.tnic>
 <PH7PR84MB18380596CA00597E9D5D18DF82629@PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM>
 <YvJ5xxsDxC4q3fJB@zn.tnic>
 <PH7PR84MB183802388F7CFCA317D3793A82629@PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM>
 <YvKVRhzpoR2Mass2@zn.tnic>
In-Reply-To: <YvKVRhzpoR2Mass2@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 80a13f4a-b968-4b53-3605-08da7a2da737
x-ms-traffictypediagnostic: IA1PR84MB3108:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sEVzxYLnPpNGUkxK273utm2pJcwTH+6zIAD194M2gHrDLTntrXT7NOIkd8JEDNnhZDIRm31YRmRNkwQK0xnRaw8m2Fj+H/a8zuSC03Tpu6Iyk06RfcVVSyuOxCRwK0a8p/WOeK2Xzz2QA/8bmNVi2iXMQeUfsJLMkVxzt7dY3urzHTMf25RL20359e4fDI8UELDFOblTw6psoUiiE0BHuDvyZ3wc3mB3PtKmVGtzu+2MyTwzoZp0Mq0QHEVEZ/2SRE1eQwrZbLxWYb/x7/0T5nE9MGzORYlxmHXO6GDzXS3kw8ED7pmtbOXeEPIBMtspnFNtO2Q205EbztzgaTBQD88/4FA1E8/S6qJVKihzhAGPRMQZOVEHDzOkkCMcccJqLENEuMFKqjhBEX53lQzsH6GtRUVwAvMwDdMG6Idbi9MDCbJAgOfJ06/kLzEt0z/TObZrsfNOagLPskLerjH/WIOtbR1j9fKkyF7em7jl+r2O6nNGF0KxMCq3q7p96bFzANxYqBT5SSQwJTp7tHM7d9AEaNuSY6Ibca250q7L++LH3ytgsC3jriDQibSPZBvGRoI5GBZ5medYyqrOfF/q+7haVcD1Lv8HQnRCwkx8c4s4eO0DPhivBoFbcP7m7zdP2InxJTt/3l6giwd7OnpxEq5AhAEni6CQSTjzpxzN3gDax6j/Surnkulrj/T9/fQTCkE8xAN7B7ZDj1/YgeoKf5Y8pAjMz2ih29lQwzx065t/oQrwltJ4OuGqBQE4MMBY9ZPoJ5+fk4SoTBfhlzR1Dq5DXVT1CgdpW4YV5maApks=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(396003)(376002)(366004)(346002)(136003)(9686003)(26005)(53546011)(186003)(6506007)(7416002)(71200400001)(8936002)(7696005)(55016003)(478600001)(33656002)(224303003)(4744005)(41300700001)(83380400001)(5660300002)(122000001)(38100700002)(2906002)(38070700005)(86362001)(4326008)(76116006)(6916009)(54906003)(52536014)(316002)(66446008)(66556008)(66476007)(66946007)(64756008)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cXkxNXNoOUd5U1dtQ1IvTUdkclVpT08xTE5CWFNCSXdzbFNHZjVrT01YYnJr?=
 =?utf-8?B?NUJKbFBHSmd2WWNja1dJbGRpMkI4VnkzUkNKWWtUMmlQQXQvZ1FYTzlPd2ZG?=
 =?utf-8?B?UUlwMjVtR29kUzRUcm1hSHllRHk5RDNuc1lndXZzUG5ydkhFbjlWbTh5WUhJ?=
 =?utf-8?B?Y2VqNVNpTllKRitvYVNiZCtvUGtsQ2x6VWQ1OStxU2pGbkRlNkJpUDRjUkVD?=
 =?utf-8?B?ckwwY0IvOUNDaTRRVzlETEZxakdtTU03NTJhT0N6VjV3UldJb1BMQmI4L0ZU?=
 =?utf-8?B?a29mNnltRE5TSmJuSEVBVGJaOXE4dDNrQVdjRHlPekpFZHlaWjdFaFNwU1I2?=
 =?utf-8?B?dDgwNWVXQUpleitWNkhBSElrUmVQQWR3TmU4QmtaMU1jSTdmbWtsRnJibVpG?=
 =?utf-8?B?VU0yY3h3c1ZkZ29lajFmVVFiM3VRbFlJeWVTU0NBemY4VUtKdk5hYkF3YkN1?=
 =?utf-8?B?L2hTRnZCdjFHcVBVeEhiVWpvcFBMMitsbG85dkVWV2J2TU5wcEVtNEFTVXZk?=
 =?utf-8?B?WXVsdHltUjZ1THV4ZGprN0xDWFhtcm4wOGpYTllFY01rTXhSZHhZQXdYdWdt?=
 =?utf-8?B?ejZMd2Y3SnNCY0Q1RjJibnNzczJhbVAzUStsUFZRcjluL1VSVGFkM3ZKQkZn?=
 =?utf-8?B?YloxU1hiOGp3MGRUYjZkREJXSWRNY3J6NERIUlBKdjVqU3NBSld3eXhvdFVO?=
 =?utf-8?B?TUJVRkFxSEtXb0FpY2lxUDNTRmxtNld2NHl1N3JSbVRIR2VlRERFSm1YRU9Z?=
 =?utf-8?B?b2tBbzJRVWRXT2ZHKzViUFN6REhBTlZYeG5wZ1I1MGtHa1YxZmtuR0Y0cUFx?=
 =?utf-8?B?cWxSSlRIZ09DcVQvODhSUHU3aFVjQWl2QWwwUzFEeXVhN0tpMDF2SmZzR0Nt?=
 =?utf-8?B?bG5lcnoxMkVYU2NGU2s4ZVN1YWlNL3ZkMWoxSThPVFl4djcyUFlKaHFxRnNJ?=
 =?utf-8?B?S0ZsQ1M5VElPYmVjTG5lNXRIQWNiN002a1VQMzdseXlLUFFyMzFWcDQzNDRv?=
 =?utf-8?B?TW0wY3ExR3Ntd3VaejdBSzJiVEpHQWt2MVlSSTVyS0lacXhBYklWdkdmUThx?=
 =?utf-8?B?QkticTMyR3R5VGhvMXNiaTRuMEx6UlQrUjF1UlY5eWlram5CbzlOUEVJbHpH?=
 =?utf-8?B?Nnh2V0paNkxlQStzdWJ1bklZVXRZUnlxSW9pN0lTVmtxbUlGZ01YUU5kZkor?=
 =?utf-8?B?WjJtczRmWjRtRXpmeUpoUDhwNWlnR1FQYk9hRW9Ubk5QZzBTUzNWbTI5VVpU?=
 =?utf-8?B?cnl6aStMYVI1aEp3VW94dVYwcDAwTzlpeWFzSHRDYjgzVGZhRTdpM01vRmFm?=
 =?utf-8?B?WUw5SjdLN0ZFeTZsZlBGeElDTFV3T3JWekNPWTd1N3FHbkJRbGZiWkQ3dngw?=
 =?utf-8?B?UXU2azdBa0NIWmN2ZzF3YU12ZThwWU1Fblo4ckNnQ1NtL05YK3R6ZGlUQmtV?=
 =?utf-8?B?S0EycGsvTHRRTHFOVUw2RW8vRUZxL3V0d0FuM3BJdm96V2txbkwyWVUrUGhU?=
 =?utf-8?B?MDhwdzd6QUMrTVBFMklIUTZ3ZGlPMVE4Qi9jNXdXekRJZ244aHJEdXNjSXZY?=
 =?utf-8?B?cm95K2V6YWViSTcxZEcwTkFFdjh4TTVXVmxsTHlEMzBGUGdISjBnT3R4M29Y?=
 =?utf-8?B?Vnd6OHFQVnVsY3libjJUQmlrZWs3VnBGazhCOTZ4ZDhOZ1RnRUtxeWg3V1ht?=
 =?utf-8?B?YUF6Nzd2Tk5GeDVQT3dNd2gzcU51akFDeE1EUHdpL2ZkRHFWSWlNaTVxbXN5?=
 =?utf-8?B?Y2FoUlJiZlh5clpDQnl0M1JuNWtuRjhsOThQRjRVUjVaeVYrM0x2cDNGdWV2?=
 =?utf-8?B?TVhWZU50M0JGaGZ6SGNvTFQ1NXNYRWJrQ1lreFlMblVKTE50NEF5aVFEZmo4?=
 =?utf-8?B?SFRQbVkvMFBVSXF4OTVYVi9pUWxKbFZyYWxOWjkxc25jNHppb0l3YTVIaTlz?=
 =?utf-8?B?WC9mVVpBajJya01ndTViNzhGcWYwaWI4bk43MzEyb1AvQUpUS2NlUFpaanFF?=
 =?utf-8?B?UXZKemFBckc3aFNZTzNyOUNHekxsOXJtQUkwYW04ZlRJQisydjdOWkg5b3NB?=
 =?utf-8?B?blc1WHhLbEJ6R1JEMFphNXpsNkx1R2dKb3NDUDRYZS84UFlEUlpMenZFQ1pM?=
 =?utf-8?Q?Cu7cux2ThQ7dZEsNnAJ5z2K8M?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 80a13f4a-b968-4b53-3605-08da7a2da737
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2022 17:36:12.3564
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Om3xvxrouPSxtssL8mc+1TR3L/ekNAY2U/zxivy9Zk4416/Ywbn1iwzqmOW18x2ufPFRPoiPfMbJGn+tTzL2zA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR84MB3108
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: e4UZyAM82r72B88yQ8uu3_WPofH8HIsA
X-Proofpoint-ORIG-GUID: e4UZyAM82r72B88yQ8uu3_WPofH8HIsA
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-09_05,2022-08-09_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=897 mlxscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 malwarescore=0 adultscore=0
 impostorscore=0 suspectscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2208090069
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

T24gVHVlc2RheSwgQXVndXN0IDksIDIwMjIgMTE6MTIgQU0sIEJvcmlzbGF2IFBldGtvdiB3cm90
ZToNCj4gT24gVHVlLCBBdWcgMDksIDIwMjIgYXQgMDM6Mzk6NDNQTSArMDAwMCwgS2FuaSwgVG9z
aGkgd3JvdGU6DQo+ID4gSSB0aGluayB0aGlzIHNob3VsZCBiZSBhbGwgZWRhYyBkcml2ZXJzIG9u
IHg4Ni4NCj4gDQo+IEJlY2F1c2U/DQoNCmdoZXNfZWRhYy5mb3JjZV9sb2FkIG9wdGlvbiBza2lw
cyB0aGUgcGxhdGZvcm0gSUQgY2hlY2sgb24geDg2LiANCg0KSSBhbSBub3QgZmFtaWxpYXIgd2l0
aCBBcm0gcGxhdGZvcm1zLCBidXQgQXJtIGVkYWMgZHJpdmVycyBtYXkNCm5lZWQgdGhpcyBjaGFu
Z2UgYXMgd2VsbC4NCg0KPiA+IEkgd2FzIHJlZmVycmluZyBhIGh5cG90aGV0aWNhbCBmdXR1cmUg
Y2FzZSB0aGF0IEFDUEkgR0hFUyBtaWdodCBub3QgYmUNCj4gPiB0aGUgb25seSBGVyBpbnRlcmZh
Y2UgZm9yIEZGLWJhc2VkIG1lbW9yeSBlcnJvciByZXBvcnRpbmcgdGFibGUgZ29pbmcNCj4gPiBm
b3J3YXJkLg0KPiANCj4gRG9uJ3QgdGVsbCBtZSB5b3UgaGF2ZSBzb21ldGhpbmcgZWxzZSBpbiB0
aGUgd29ya3Mgd2hpY2ggd2lsbCBvdmVycmlkZQ0KPiBHSEVTLi4uDQo+IA0KPiBDYW4geW91IGd1
eXMgbWFrZSB1cCB5b3VyIG1pbmQgYW5kIHN0aWNrIHdpdGggaXQ/IQ0KDQpJIGFtIG5vdCBhd2Fy
ZSBvZiBhbnkgc3VjaCBlZmZvcnQuDQoNClRvc2hpDQo=
