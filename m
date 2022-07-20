Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05B5657BB36
	for <lists+linux-edac@lfdr.de>; Wed, 20 Jul 2022 18:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbiGTQSq (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 20 Jul 2022 12:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238147AbiGTQSm (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 20 Jul 2022 12:18:42 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B0954645;
        Wed, 20 Jul 2022 09:18:41 -0700 (PDT)
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26KEOnnj024923;
        Wed, 20 Jul 2022 16:18:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=bYXpX/0RNuAoIKJeCGAWX1dKg6CcRfu49bkwpVLssRo=;
 b=NV6Z4B7OE353SJwoM7fm5hxmNGfdCAhYmCLgYR4rDyVj5wzeDw/K9K4Lz+AEEGDffdjX
 crMxp5EPhvt4sRAv72juR6VhC03i0P3opX19z7Nr1J0OvH/fkiLPjWXSoeNey4zBlei8
 lUg5wYMmqD4yi7j4GclDt1vSs4G3l2Z3R1eMjJaAz3EDvHVbvruUT3KYFFFqymyCowB5
 5UsdBkJSIV9EBiJAxF8p2xkO8/iNLL14zRVej0q6rCX6GQs1dlYn49HTFCMACzZsNvOV
 rRFJ97z+ShL2beKbP08KOSONkZTNJQ0vZ3nkN4qsU2y9rc5O9EtWjb39HO0A9QSzioWl xA== 
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3hekep93qb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Jul 2022 16:18:35 +0000
Received: from p1wg14923.americas.hpqcorp.net (unknown [10.119.18.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 4B0C214796;
        Wed, 20 Jul 2022 16:18:35 +0000 (UTC)
Received: from p1wg14923.americas.hpqcorp.net (10.119.18.111) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 20 Jul 2022 04:17:54 -1200
Received: from p1wg14921.americas.hpqcorp.net (16.230.19.124) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Wed, 20 Jul 2022 04:17:54 -1200
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 20 Jul 2022 04:17:52 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EmmAhbAEPH1a2WofCRdFwfbJjw+urz7byN1tN3hxHQGqwaQc3Z9wsf2y2CYKzq/atKKGCYAy+mTSAuwE+NPQSD2KQioRz1UstU24tS3IRcbhcKDm3dKhdDr3CtLJgGGJ6NPeRy1LorHnVcAoes4/wWotLP61IBDY6r2G3CBwiE/yRuJBAwPQWRGJAihVBINdzcK83l26gaUxlDQit/qWe8jTSE3UK3t/dI3LEWtm9V/cg+7q0dRe1k23RDGutMG4QvtgGvSUEg4pK3Y+U/BMtB9vKg94ubcUl1SYNeUmAeZ8g/fZP2mdle5oafPPoDlkVHhP74WYgUSo8bL5G8F5mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bYXpX/0RNuAoIKJeCGAWX1dKg6CcRfu49bkwpVLssRo=;
 b=Ccd3Slr9VcY3hGEi6Appu5iEUmynk8EiL4eTOdmL9PNrylCfBPIUSgCHnfwFPYZQ2UrfmGRVijeQ9KQ1tWVZEarlkXvNXQBn4AOA0uqHaV+8Sitqwu6SbF54wap/bwBcPW5PN+Uu4yeTZnVKxnqYolG0+2plYuym2Ue/OIcPz70cOEcPhKy5t1HiJjeGFYJbx/L6YSb/0GbfwhSGA97G6Q4z8wAAsLgmsicgozHS7KNtlPTyCzFwkUlihvhGgHSoOEbtK1wLiuy7V3SG80JuxP99C5mjFlHdlE13gTifDGSgOcQe1sqMAyKtadEoexINrh0BruHPteqDUTupMVzlWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:154::8)
 by MN0PR84MB3046.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:208:3ce::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23; Wed, 20 Jul
 2022 16:17:50 +0000
Received: from PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::c165:fcd6:a6e7:3f06]) by PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::c165:fcd6:a6e7:3f06%7]) with mapi id 15.20.5438.023; Wed, 20 Jul 2022
 16:17:50 +0000
From:   "Kani, Toshi" <toshi.kani@hpe.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "rrichter@marvell.com" <rrichter@marvell.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "Elliott, Robert (Servers)" <elliott@hpe.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] EDAC/ghes: Fix buffer overflow in ghes_edac_register()
Thread-Topic: [PATCH] EDAC/ghes: Fix buffer overflow in ghes_edac_register()
Thread-Index: AQHYm7smwrVZqUGvIkiseTl/uQAs+q2HJpiAgAA/+tCAAATmAIAABWQQ
Date:   Wed, 20 Jul 2022 16:17:50 +0000
Message-ID: <PH7PR84MB18380BBEA0E8C1A4A3721865828E9@PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM>
References: <20220719220124.760359-1-toshi.kani@hpe.com>
 <YtfsOcWbWREu1NnK@zn.tnic>
 <PH7PR84MB1838CC03943D28806F7DCD8F828E9@PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM>
 <YtgmALzpaR9IHR/F@zn.tnic>
In-Reply-To: <YtgmALzpaR9IHR/F@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2886ffbd-7f20-4748-aed2-08da6a6b648d
x-ms-traffictypediagnostic: MN0PR84MB3046:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E7MuYOcQtNkFVZTAle0aOMjWfJz0J97jhcix2I6qkfbpua7ZM1evgW77VFXXpVWZSGEVbK9gx6cGIfthK2LaeU9b0Hoh5c4FwmZBQzclJM8N+KKLl+zhsqlN7IsDEfj7vccAUFQ4pB+Fyy4rhzDjmPY22WC5Vxm83nN6a8NCkJ48OSId0HlyCMtPvxrH1cYZTuhGkEWfm/a3ctvJY0SYJn7rUoUmDU2FBvj91iBBb1QWTCyeONfDqjKZ3CDDiq13//AI9lx3pa9J/oaHMOLrjo16On3y1AX1jESjIXla62UeEYcnzR2QY2sbnxnCF8Dww8r47mh2Gf0hZtNFpA6RbkiNu2lUnaQ5k75ah6G6q9iTmMbqbrnMq5eQuowwtNm5n7OWKaoq0JsHRtOVg70jS1viAl6zxnrn3WGNQm478Bvy9m5NGlvaUFgqYkcpyDXhiGD0Vlah96iKzKeZGsIz+pITbk69UjDNZe3uR+a3/RYMtl5PWUIZ/T0ClEPYKcRvPMdEmoo+ghhjbD0H2n55zyTj5nRsRVYGKuzYW30/Y3XPUeAVwueTROj9JMgZAkLRF59hmYGxA3yLj8CB36bSwq7LcpuHRT22masgOpTY9PDDQ1rPQkCpw4gDSFmjVRNO8U4DzezHJkd8InlxbHcC3q4u7PRLpO8bdw1EM17q+ad5juEgGfS5E0Zl2zKtYV9m9eshapW0TsfmqxcQU4CYcfliTPSZlXVkaqZcOuvPi8stWi+inRiJK8jAlOL6dcdr1vNhtRcEEgg5B91XlPAT3q418RZmhA4cYkN4dLJCW6o=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(136003)(346002)(39860400002)(396003)(366004)(376002)(4326008)(76116006)(6916009)(26005)(54906003)(9686003)(4744005)(33656002)(478600001)(41300700001)(122000001)(186003)(71200400001)(66556008)(316002)(2906002)(8936002)(83380400001)(5660300002)(82960400001)(6506007)(38100700002)(8676002)(66446008)(64756008)(38070700005)(55016003)(66476007)(7696005)(86362001)(52536014)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WTZoU05jdWhnZDNoRUJuc1l4bGFPN0c0NGJXQ2hab2dKS0hxQ0R1V3grL3Ry?=
 =?utf-8?B?QzV1SDdPNEszWGhxcEdCcmJUUWo0UEFWQ0lDU0FjOFlmbERIZXR4aFQrSlpQ?=
 =?utf-8?B?TjN5NHFReGdlTE1KbnJKRndCVGZ3TU5IZGxucmQzcDJ0NGdEV0thVmQ5M1hZ?=
 =?utf-8?B?aFV2L3d3aXI1MzNQRUEvQlZlUWdpL3ZkV21VZ2REMzBSbnlIc2hUYmZ4VEFq?=
 =?utf-8?B?MUJKRXphaW9UM2h4TmFHMjZJZ3l1YllsZ2VhRFBIY0xBVVFFc3pmVVpsT2ts?=
 =?utf-8?B?aE1MZ0ozWUNDRWNidzl5a1VHOVd2YitxY1pJZ2d6dElJYm1laVoxdUxDZDN4?=
 =?utf-8?B?VVVpTTVkbGhRSzFtRWZFL3ZkNy9YeEVXbzdJSDlMN0hVRTlpR2F2NzBMeW1o?=
 =?utf-8?B?WGJCNXg4WjJNN2pJVnZRODJkRHVpN2Y5c3drSnpiaDBBaDVaVkgwcjhtK1Ur?=
 =?utf-8?B?Q2VrWXo2YnlzcGd6RWQyMnZmR3Q2RitFaUx6ck01SGJBSkJiTjc2bXhaVCtH?=
 =?utf-8?B?ZmhQWWFXb1AwWHk4dFdWQVNxS25ISzRoNVFXYWdtdWd4dCt3SHhMRlY3ZmxW?=
 =?utf-8?B?TGpwdVVDK3NTcmg1S0ZCNk1EV0tOWjhrcGlyd3BtZnZCSnJrMjBMYnNYQlRE?=
 =?utf-8?B?dnptcksxZStGN0ZLejFmbnR2TjhHaDF4ZXFVN0xxK3hzSmtaWUM5WW90UWp5?=
 =?utf-8?B?aWxwMXVibzFyR3dkMm5WSHBtdDBoWWFtbCt1STd3MXZuUm80NlROTUlMN3Vk?=
 =?utf-8?B?ZFlPaFdWV1NzL0pXUHYvdHhKdkp4OHJUUGFxMi9RcXNzVHFEVXk3YTVmTFV0?=
 =?utf-8?B?M2pibCtQZlBrUlAzMi9zYVJXNGd6V202dEZzcFdVQjZtSC8rZm9heHQreFRR?=
 =?utf-8?B?bmZuV09OaGVacWZ3YlNTVDA1Y3M4ZGVtRkt0MHRNdGY1YklXdFhmeWs1bkVG?=
 =?utf-8?B?aUlHMnllMVdYaTZWcHNwY2taanpEcTFFMXJURjlDZjlPN0IyM29VcmVRblJt?=
 =?utf-8?B?OUpMSDJZMEMwamdXY2p1Y1ZNOGZCajBDMXZyRlBaTms5Rjl4dzlSMG9ldGY0?=
 =?utf-8?B?eE1LMUpuYjZ4anFMVjFnWHFhNmFBeHZKbVlEMzIyQWdYODlDK0l6QVVWMUpx?=
 =?utf-8?B?RzdETWwxWFdueWpaRFE3c21LK2dPOG5WRUJJTE1rZ0czZ0xrMUdZWElJMTdP?=
 =?utf-8?B?NlhNWithWU9xZzB1cE5ZS0ozNWlwRFc0SE95L0JoTlg5QzMrejY4Zys1dVdY?=
 =?utf-8?B?RTgyVzZiWWlTYkE4UmRhS2VidUd3amR1NFc3eGRobUdUcWRtRHVxbjk3ZFpN?=
 =?utf-8?B?M2tWbXJiQTlEcnlpb0ZMUnRqV0pIWGk5UThNS0xMeUNsY3VaWnlsWkxSc0ZY?=
 =?utf-8?B?dWptajB3ZXRaYThlOFZGNzlKemdWTEFyNlBFL2ZUd1NRdDI0UUlweGtaSmow?=
 =?utf-8?B?Wk9wcHNybzdGZlhraDRhVWV5dmE0QU5DNEZvSThDSTM2aFI4N0gvZmpMcTBI?=
 =?utf-8?B?elFOMW1aekNmRjBiU1l2eS9yZ0JGOUdCNnNYMm1odGRadXBwM3BSV2VOMitH?=
 =?utf-8?B?NzNBbSt6YVpYMFZNM0wxSm0zcmovVVZqc1NTdGhlTXZxSUZwNFdKUmpzMyts?=
 =?utf-8?B?VnlLbHZ5T1FmZ2RROTRNZkp4eGo5REF1QXZGcC9FWjlEbFcwVFNvMll2RXFv?=
 =?utf-8?B?RXhUOWh5SFZuME8vcTQwRWdEYU80TUNVTzE3RVRXS2tmRDlyRFVwTExXSU42?=
 =?utf-8?B?ZHlBYzRpaSt3YlhuYS9HOWJCZDlVSi9sZ3JLMXN2Zi83WEN2UjFxTWg2VjIr?=
 =?utf-8?B?aUNkOVR6UnQxeUJDMGF4UkZQUzZVejFqdTZWYUZCbEtkS2QwR09vRWhaNzlo?=
 =?utf-8?B?cnQ3Sjg1UnhTNy9zUzFnd0VzUkp5VlJxR2U1dUIxejBJOTJzZkM1Sjg5Zisx?=
 =?utf-8?B?N2hTU2x4Mk1RMWdXU2Nlc2lDSk5hUW8zMStTTDZVck9NM3VYcnJXSSsyUmJk?=
 =?utf-8?B?YVZUNkViMXdsTGVOSnpaT1cva1NBY2tNMWJSZWZsbEZEQ2M5MWlSMXo3R0pH?=
 =?utf-8?B?NmlrdlU3SXhnNDY3QzJTNlBtNXZYTlpJZ2RaUG4zNDZ5SDhTaVFORTBtcGl5?=
 =?utf-8?Q?ZaqX70MBZDLtPWlQh+FzJQWWy?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 2886ffbd-7f20-4748-aed2-08da6a6b648d
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2022 16:17:50.7242
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cxTAeaIsce68P3C9oL59aPPnyuQtQ6lSXy6kItJ2y8/tyPjq4rr6pnJm1Aca/K16ow7B1x4QVSQJz63nRxDFZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR84MB3046
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: P9b_lxdHl3MLJiwoGJTl0sYlF44k5-9J
X-Proofpoint-ORIG-GUID: P9b_lxdHl3MLJiwoGJTl0sYlF44k5-9J
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-20_10,2022-07-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 bulkscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0 mlxscore=0
 clxscore=1015 spamscore=0 adultscore=0 mlxlogscore=551 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207200067
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Qm9yaXNsYXYgUGV0a292IHdyb3RlOg0KPiBJIHRoaW5rIGl0J2xsIGJlIG1vcmUgdXNlci1mcmll
bmRseSB0byBwdXQNCj4NCj4gIlBST0MgMSBESU1NIDEiIGZvciBkZXZpY2UNCj4NCj4gYW5kDQo+
DQo+ICJOQSIgb3Igc28gZm9yIGJhbmsNCj4NCj4gaW5zdGVhZCBvZiBzZXR0aW5nIHRoZSBsYWJl
bCB0byB0aGUgTlVMTCBzdHJpbmcuDQo+DQo+IEkuZS4sIHJlbGF4IHRoYXQNCj4gDQo+IAlpZiAo
YmFuayAmJiAqYmFuayAmJiBkZXZpY2UgJiYgKmRldmljZSkNCj4gDQo+IGNoZWNrIHRoZXJlLg0K
DQpHb29kIGlkZWEuICBJIHdpbGwgc2VuZCBhIHYyIHBhdGNoIHRvIHNldCAiTkEiIGluIGNhc2Ug
ZGV2aWNlIG9yIGJhbmsNCmlzIG51bGwuDQoNClRoYW5rcywNClRvc2hpDQo=
