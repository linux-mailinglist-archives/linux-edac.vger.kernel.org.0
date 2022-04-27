Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADD1F510E3D
	for <lists+linux-edac@lfdr.de>; Wed, 27 Apr 2022 03:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356861AbiD0Bne (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 26 Apr 2022 21:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356865AbiD0Bn1 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 26 Apr 2022 21:43:27 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70082.outbound.protection.outlook.com [40.107.7.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D284EDFF8;
        Tue, 26 Apr 2022 18:40:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W06O0l5UZnqb9PoUZ3ZTUh1a2vWUsnXsEGHAEBzjulrW+jMvr6G3+h2bMubuvmbAPPHMvsuqPNgja1eRRngpXrc6aS+fc6KF9yZK4R39vS4J2uNB5goaP2iSf8ROWL4WaKFiYUZH7kdVtebr8DT72uqZHvyvGQ4BMRTzYvC7w37TTM0u6Pz6TXFl/bktI0UONCig3h5WehxJPVthpSW56vrdZaThVDrXH1K3zl4Au+uaoMlEz0IGKdNzcbi2OBOBLpvG+6KzfmFt9+CIgpLwx8NWoAqWHRebvsJ6IMvgAJ71FM4gPxV/55oBHT66IaDkgNg0igO9UK255n/Bn+ym5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=12Z0jxnFVGtWAsMzeW3Yzr8RvzH13m5RACMkAeMTpbY=;
 b=NFm7mgAavH1ED6v918sfIG7vt1q4aAFjG4Fn5CAe+DOJnLv7d/yfzBukuv01jBzbVJYbsg5NLue2L5myTr85d6Cr9FpHlpYD/KnpUZc+fCkbbCSAXesPrQqQgQbE2NXEHnmGGWh2PMboQWG/iBoLB7kGFDqmbnOS1Tf19jzx9oFr1h122OXXFb7U62/1Qbr/iaqaV/fix/ZRB2npjrapk6dQJLC3tbkM09Is4rdXuIDbua0v2a6se3vXRa+pmIRsuKKFEigZeKOCFIvtPMiioT/+WGAukyXa1tssAQzRw5eZYuUr1GPu3sQtiF9X1u7VSDxgRSGfnBA7YNQVR392fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=12Z0jxnFVGtWAsMzeW3Yzr8RvzH13m5RACMkAeMTpbY=;
 b=XybI7EAcewfMMMlbxdtqa176zs0BwD+6Afu56FHP9XfmyTc7zQTE411R0XRK2W/NjiEgtN1H8hwU2Vf0UgmSs83v0VBxuqjK1ykipGSNGTAWvhkCYWhCT4RfoMP3+t3NxoIZC3yQ4BTPuM80y2NSq6IoP+IUJ2RlpAA9X4SyXEM=
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by GV1PR04MB9216.eurprd04.prod.outlook.com (2603:10a6:150:2b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Wed, 27 Apr
 2022 01:40:13 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::1cff:564b:c3cf:46e6]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::1cff:564b:c3cf:46e6%5]) with mapi id 15.20.5186.021; Wed, 27 Apr 2022
 01:40:13 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "Shubhrajyoti.datta@xilinx.com" <Shubhrajyoti.datta@xilinx.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "rric@kernel.org" <rric@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V2 2/2] EDAC: synopsys: re-enable the interrupts in
 intr_handler for V3.X Synopsys EDAC DDR
Thread-Topic: [PATCH V2 2/2] EDAC: synopsys: re-enable the interrupts in
 intr_handler for V3.X Synopsys EDAC DDR
Thread-Index: AQHYVSMQdKtwPj34AUOq3rkHbkAYhqz6FAQAgAL8+3CABUDYAIAAsKUQ
Date:   Wed, 27 Apr 2022 01:40:13 +0000
Message-ID: <AS8PR04MB84045EE383A9732D6A2E8DD992FA9@AS8PR04MB8404.eurprd04.prod.outlook.com>
References: <20220421015313.5747-1-sherry.sun@nxp.com>
 <20220421015313.5747-3-sherry.sun@nxp.com> <YmEerhSXM0L8cUuj@zn.tnic>
 <AS8PR04MB8404243437B78FA6B1E46F3092F69@AS8PR04MB8404.eurprd04.prod.outlook.com>
 <YmgIiPzvgO3CdlqF@zn.tnic>
In-Reply-To: <YmgIiPzvgO3CdlqF@zn.tnic>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4926427d-1404-4f31-9e51-08da27eedfb7
x-ms-traffictypediagnostic: GV1PR04MB9216:EE_
x-microsoft-antispam-prvs: <GV1PR04MB9216CB4E002C522A4C0DD80F92FA9@GV1PR04MB9216.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WOlKTzk1XhiRBqDxk+U9OjKGqsYumMAvdN9zdo6fStCDIs+eXjydouxHv3KAjLXEwni5eg1nG7rxICKVMPptTUCQMjR192QDyYkvHA65p957sGX1sZ/ertt0CqLzZiD21KAXoMaktmp+Kp2CKhSvBMLGmsGahmnpfPmix7ve2vxndn7eInmVch/DbqsVU9chTLz0vY0NpegF1oL8MioIcEEUEtgJzE6U1kFRRf9UOUUweQ4CkAwLqKjByl9+QkmHUaJlyyeSWy1ABEM7z7pJ/5gyM4HCujI5YeDowu989oxNHwmfWzR4c9SrtfXA2IMpL2V3QtrP94GZasgpvStp7ipqQqavMHKS0BzYws7QD7ss+E4nw/0OKeyy+HE02Wxhea/2HkgBDVXNJ1xPBrLlqdYv1qZPZ03jFPyP8FZswL7RdYpdQU+cGQMr30EDrlxwfxtt9MF0JQBoCih4QWO+3zNeVj05DPcL2oz0Dm3nZZ1iTyvyjIjVq3rQYF+si7Zl/0UpNHYTFt47nG8vgR9xFRh77h4AZqfNNJx3TB0p807rjhF1HiHU0D+hnz/6Qs487ud+NnzBmXHV55/sFmnfWUa43mViVwzRbkxHC33JzcqDSzA18SaLXInB0ezcOK1nfLHN0mbowCC1XVCZFeQBPORtB6eqNHaGwwsq6zux6aROC1YMdfoR9g88ExGzPdMKHFZZfk1i8/d3+GQTDhiS2Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(26005)(7696005)(55016003)(2906002)(4744005)(7416002)(186003)(8936002)(44832011)(52536014)(86362001)(122000001)(508600001)(5660300002)(33656002)(66946007)(76116006)(38070700005)(38100700002)(54906003)(316002)(6916009)(71200400001)(9686003)(4326008)(66476007)(64756008)(66446008)(8676002)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?89cMAdm8LDCl5pKKF2BV7xwUZSA91ivGHdl4bQ7cCiMR2JBkEvll9fToCNLK?=
 =?us-ascii?Q?d3j6nVZw3r1EPCqJMDMo81bFSWo5Idvpc1Zx5Hc6uM+7mg2TfIQK2dNLR1xV?=
 =?us-ascii?Q?tqtjNlUFO4ERDenS0LSqZ1nUvhbmgwe7sdE4MWmbW84xtbzIy2lyw/Zqfh4w?=
 =?us-ascii?Q?H85ooJjuc6RTiCNor8Gdd9S9zHRgTgbeh/k++bpud3ShMgCfapU512ZXYPP2?=
 =?us-ascii?Q?YiCuWuOBaCMNbo0M/oCzyiEoS0siG9z0e29ZoxBgKfjixT7fyN2mLa75VA0F?=
 =?us-ascii?Q?KhEOGeTyWnYohOS82gGKLNeG0IREu+pRegWwI8yN5p343O4U9Fsd7EUxgKXv?=
 =?us-ascii?Q?z0J6yO6oPqCEK0mk8vWW7AFJeFYtTIZ3fLfiWTWl0U5/nYHh2ve3l9oijKkc?=
 =?us-ascii?Q?6pyNkx1X5TJSd8tqrc1iS5dw9h5Hm8ltxBp6GE4hhQCxObIW7fXYUuEU9ScI?=
 =?us-ascii?Q?5qduBIgV6KGKwGj2Jqati5MkxiMUYWphmEd6SKj/Sm641+JKLSHYNzehTQQj?=
 =?us-ascii?Q?SPQs6dsVz54pNi05k3NO9LufEj52hSAUfry5ZarSgxttnfjpBZyxQtItc+xW?=
 =?us-ascii?Q?Brn3EVZWeCTZrfZeFl1imIhoWUamkczhJATC9FRy3mu3gtjeq8fFJBYLjSKm?=
 =?us-ascii?Q?efnyMR6+EHSBzexqZ88Emka4GQ1Y5vw3/xRnX+DcQ83FI57rvPGPCYr++M7Y?=
 =?us-ascii?Q?n2dem9dTHjcTfgI/6qzpR5azb6QwvNR3xZk2Bfiol6/Fc0F39sF4d9ug3hOS?=
 =?us-ascii?Q?xgDVLAgcDveKciPHaYXpqUvI7yj9kMur2RtpD3wLE6xjsAIGqjMiLL1EAe1h?=
 =?us-ascii?Q?wKqZ9P9HDHQFFcvmqIFSrptY5EEYRr6H2lQ4CLGwVftSssrBBsp/HDNeFArZ?=
 =?us-ascii?Q?DGBz7/vd40sYjXF5/z7dhYzx1PmhjKxt37jocnkK3/BDAk3g0eAAa1fnrodA?=
 =?us-ascii?Q?A1ZonG0hE3a8tzUjWnDNfMqdKv49kGGEJCigC5YG06B/kNNOetpmWodSUgrL?=
 =?us-ascii?Q?AqJtDVZrDKJ7Dupalqh7p3kx4pVKJT403Npx4E2z9s5O4wNmENDzuSOBdSYq?=
 =?us-ascii?Q?gSkbCVuoEzGL7v1zWUEOqcjl1qhpEhbCgvhQmxeJN8IQQZQ9FE5IJseLuey9?=
 =?us-ascii?Q?ko6hr5fuSHSX5+neFDjfeF8oGPecNdjBT9SMy8zrMRy+GYPyKRX3JqIf7YHB?=
 =?us-ascii?Q?pEibv6Zfv9bV6Dg6qmEfepHUfGOhPBvkS4DFErkbCWB0JL6KCq4oD+Rf1um6?=
 =?us-ascii?Q?bzB6OUAmY9TRVlruxGlUH2JofAPeuPTM9hCQ2qybe35KpOUzzgqFJkQls5yG?=
 =?us-ascii?Q?h2HTRZVkVXgbeAXRPGId1Q/MFU681MHpwoajUpGmrWJvilLcrv352coKMGSt?=
 =?us-ascii?Q?qFZNP52BnsLpso8eEhczbRE+Ij2A9Gp3SH7Ns+KxWuHgY8a1OM3NvyZQ57n/?=
 =?us-ascii?Q?okno9SpfmdTkLwGr5McSbwhOIxGDuD35qfd4g3+NhY09eX+7oomVFl83SdRL?=
 =?us-ascii?Q?n9zi12RLmnJZgKI9lpw8ErRXNn8zO5kRT3NJvnSQ4L/YpMYntYzsnd/zv2Cc?=
 =?us-ascii?Q?Wu/ICpzuwNJ4sae8WlC1NfjSdyC9KsF/rnPTz5gutTZeoiUUobuSob6eoEhZ?=
 =?us-ascii?Q?Ep2gSpXgcfWYE/lTc7nJ28Ast12mZV93R+zfvOu+vVkcmo2X9PsOBW68CEDB?=
 =?us-ascii?Q?euUf/ZEVO0fQxIE/luXycfKG6I9kDabwNTpE49fd1xv0hOSmNIrh5bevpmsY?=
 =?us-ascii?Q?2qpjvTWxIg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4926427d-1404-4f31-9e51-08da27eedfb7
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2022 01:40:13.5086
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LqRWAKncl9rAGpYC6ji2YFE/T0piLPN2Bas8iMTzLt03USvIHzRDaa+NY/NZjeRbv8Gty3ws6LtbQqE5+1NaaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9216
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org


> On Sat, Apr 23, 2022 at 07:03:45AM +0000, Sherry Sun wrote:
> > My fix patches are based on Dinh's patch: f7824ded4149
> > ("EDAC/synopsys: Add support for version 3 of the Synopsys EDAC DDR"),
> > as this patch was introduced since L5.17, it's quite new, so I think
> > we don't need to backport them to the stable kernels.
>=20
> What do you mean, quite new?
>=20
> There are 5.17.x stable releases so they will need those fixes too.

Hi Borislav, got it, so we can add the fix tag for the two patches. I will =
send V4.
Fixes: f7824ded4149 ("EDAC/synopsys: Add support for version 3 of the Synop=
sys EDAC DDR")

Best regards
Sherry

>=20
> --
> Regards/Gruss,
>     Boris.
>=20

