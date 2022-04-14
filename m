Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0856850061D
	for <lists+linux-edac@lfdr.de>; Thu, 14 Apr 2022 08:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237208AbiDNGbq (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 14 Apr 2022 02:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiDNGbp (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 14 Apr 2022 02:31:45 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D050DB0B
        for <linux-edac@vger.kernel.org>; Wed, 13 Apr 2022 23:29:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aQQnbWSqrdVBTmAk6JJzdaqtyl8UKJkNeueF5pu6W2Wu+hbajZZaStTUtFnODayElUP4kA+qYuWxjOBQFMKB3zSa0ThVCn+xil1uswFUe2pDz2pX7UePirFs9li+a1EIV1nC9oF9ADLG4XlUrZDkQyXBgtnQzDGA+YfYR8nQ91zlvSUZoCjg/rlL3/pgO8g51FpOXro6iYScJCPW72Hfo8Y8HVjqNYqUD/OulD5F5z28NAEPba24aIL1W9za7U+6bKdk5Q/NZWJxWYBxNy0MhjhfpbV3XjSLsD0Oa7jB3TC09PLhm9HHiNvdpmZO6/XMF/jdzoz0zGv7XmaUkVTyNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5etoeSP2VT4Cbuj2ICuRLpPRqblZzZQx0bIaVrxZEug=;
 b=AzeBYmE7YHcNab/JCMa/TUUdRt3t/YQ8CKFT8AOj75/MNNC+DoGiDVdMtMm2/qgp1S9hFnKtf3oh+xMIkA3Sgu9GE4EulhOE6hBA/u8ho6hKQWYRNNYj8X+XV/XLbP19HtkqOAaZ+DDbvrRWLeJ8gGbuuV8+ItnHQC/nfkyvT5jUIUR0k9e/NP/3QWCZKfH/ZbGhnXCNW8ZF4sK7c1gMrutOI8t0CEIoMxZZIJarMcgl167BazPZgPZEZaYGuO+Adi9VF5vmCQajaedGs6yBuMyEHIOZFqlzKeDOvfPyEf16t1W3yLKcUMXcb2SR6BZCobViVBK42flVW9JCAqnL+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5etoeSP2VT4Cbuj2ICuRLpPRqblZzZQx0bIaVrxZEug=;
 b=GWjg9WsakW4Pbjk2cGvsVEEgzKsddMpaAK600ibZ0O5nXVZENkx4ZUVdkzxgysY7abKkpNyn+ezxUP3h+C4w+A9vCKN7f30kIwTDaKyCgfZ4wBH0rD6/6BAEVbsGSzSKKBY8XREjW9qgKuCVp7zTGUr19D+xomDdRv/FpnMFG2Q=
Received: from MN2PR02MB6640.namprd02.prod.outlook.com (2603:10b6:208:1d0::19)
 by DM6PR02MB5082.namprd02.prod.outlook.com (2603:10b6:5:47::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Thu, 14 Apr
 2022 06:29:19 +0000
Received: from MN2PR02MB6640.namprd02.prod.outlook.com
 ([fe80::598d:e867:93d2:73ff]) by MN2PR02MB6640.namprd02.prod.outlook.com
 ([fe80::598d:e867:93d2:73ff%9]) with mapi id 15.20.5144.029; Thu, 14 Apr 2022
 06:29:17 +0000
From:   Shubhrajyoti Datta <shubhraj@xilinx.com>
To:     Shubhrajyoti Datta <shubhraj@xilinx.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC:     Michal Simek <michals@xilinx.com>,
        "rric@kernel.org" <rric@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>, git <git@xilinx.com>
Subject: RE: [PATCH v2] edac: synopsys: Fix the issue in reporting of the
 error count
Thread-Topic: [PATCH v2] edac: synopsys: Fix the issue in reporting of the
 error count
Thread-Index: AQHYOrGdArOeiTZAaUa590Hx6OSps6zvHCfg
Date:   Thu, 14 Apr 2022 06:29:17 +0000
Message-ID: <MN2PR02MB66403D9C603EB0F5673AB8B2AAEF9@MN2PR02MB6640.namprd02.prod.outlook.com>
References: <20220318101900.28872-1-shubhrajyoti.datta@xilinx.com>
In-Reply-To: <20220318101900.28872-1-shubhrajyoti.datta@xilinx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xilinx.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: adab7409-6689-46aa-ba93-08da1de01a60
x-ms-traffictypediagnostic: DM6PR02MB5082:EE_
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <DM6PR02MB50824E2047559B7429E67F55AAEF9@DM6PR02MB5082.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nRjYRfvWW/CcSrlfhUfkO8zJAo1F0QujFLS9oIAz5RaUWNd9usjGb5aEMcKJJ5fXiVXTzdLEJJgRbXA77YUM0K1gP6Af8itwIZNrFncQibMu883/XebbFCgsOIGZSnk0rtgbgMWTJTJiXzc1IjX+MV//J2dxQ5zHlGHjle+CQ+vo7EOVr9TcUXeCCY0NS72kfTT7MtDthsG4BxY4kKbCrMqrko3g7JPL5jCX3NFZwyIAC/c5UcuAEe+dM+mXVGV+jfNCO0ix1WxDEFKYRgVgzkmwgzspzN7/DA9clYma6Rl4ayKXE8HqXWJRTGBZcTdY1WYXvsUalPO9Pvll4Do26FiIzNVzRLoTIGn5iQgTNG4MpRx+qrQiAJmXnF2AE97aeKiMFROIDg+flBM3DC597zhRcuUernx1gWiVKFsRCy93V00+ugjLWUJdqvogxj0XLACEloj1myvWPA2MBe3r446cwNy62C6Y8Vr4qm4EjxbhdjVm/Q98rO7TDWnjrhXbUA8x4OIg9bcCZPGfrbdOYgMtkxw/5KaQA0j5kU6cO430vsQcE4S4WO4Ufx+yTI/56Ju35aBV9IrqtB0qHqcDcBwc7kw52RrYUx07PhCuzNv0gV72oHr74tceMrqT+dgbfEl5nBIoFzSZV23SvPf+Qh376QokyBs5kU1hplLQiOClMW7Wdg5NHBI41KRyM2KJbvIU5Ty5Lf9Bfbq8kjIWQw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR02MB6640.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38070700005)(54906003)(66556008)(508600001)(5660300002)(107886003)(9686003)(55016003)(316002)(110136005)(52536014)(122000001)(8936002)(2906002)(38100700002)(66946007)(53546011)(33656002)(6506007)(4744005)(7696005)(186003)(26005)(66446008)(66476007)(76116006)(4326008)(71200400001)(83380400001)(86362001)(8676002)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?M/N4TMhn22c+dzI8TRlnRwdM2i3Eq2wGvLFATSN3AGj7xKts5Xuyzu+4Oh1K?=
 =?us-ascii?Q?M6wCkM97fLHD+ZdXlZE3Y9krmxzP74cJCHxD067uConofSWr3lXe7+qrZMLH?=
 =?us-ascii?Q?vYeTsUqzWWnL4kH1O95sEGvdMZnNa710Z8EJD9+BETQZFzFVvxPf7KCWxN1V?=
 =?us-ascii?Q?gnr/Z1hUwASsaPGIvEr2TNWP14sgvT/13LrzXrV6Ohe86IYjhvTRlZLLRqDM?=
 =?us-ascii?Q?cSBMY2f2HCtjAipP/ktyVzo45LZ8gWuc04keFJBoft7c/Eb0btD6L7FRe5mb?=
 =?us-ascii?Q?cYWUwemjxv3eROsCmDG/V3n0lV6Vd6H9AiNUDYF+ZHfPpLRYlLzoyKAP4KCG?=
 =?us-ascii?Q?+PsceemeENWwiWy9hMjRGSgJmMXkdIsKnoHd2+WOkE3t+UHrDU7xIf9+FATK?=
 =?us-ascii?Q?LgQBRbpEqlplTvSsGr7xW9pbiyCvmeyQL4lVNnWZeXodidDe7Q+hV2+ZdoaP?=
 =?us-ascii?Q?1jYxxzLa/TJMugLuZ/Gim9pCRhGRMII53RJHnVpmAqyGyKSjnvmOltlcRBOC?=
 =?us-ascii?Q?Ip5UHSlJOiU8SalIdHIpTvzEgi+9fKZhLfRrFzVnvfLZGybD1rX7HkbFvCSb?=
 =?us-ascii?Q?rynw0FO6cRu7dPYMpxMg0LTK6t6FFMAugBtVBsFnPnKCh94V1Uhnib1DbUnY?=
 =?us-ascii?Q?8ABTcofm2qcsevzSG7csMFLTv9KU/7j3sgIGtHZ7FNzbkxvJxk/6jBhzDlQY?=
 =?us-ascii?Q?e7sPrFPc2oULKKZI9NcQKygNnobgKXIJxBbfjoplyhm2wqSH9xJ3yX2rkaai?=
 =?us-ascii?Q?bIHuf5KXWjx9mgPuFmkM/ghTA6ZfJrO1ANq6zqAYih89OFFIH5OjrJrbD8/C?=
 =?us-ascii?Q?xdOuQ0ul3B3FPo6/u1sI6RXnAxdtv3JK/D6pE678vOQrRSsyTYEhxnbRtARH?=
 =?us-ascii?Q?431kZk8bN76YtETDJOPSHvD/UVEi3XB7iw5mNgUiORfXPPpbb9IBOpTe/W0i?=
 =?us-ascii?Q?0AeeBLEJ/VDtHeXrdOo0ISm2lEU+PZxwUBLujMIAwujPdWeH9FeW3qbWLlSe?=
 =?us-ascii?Q?dmLuKtG/JBx/rXHKrdDIFmsr/fjyJvv0iPmxZSBWAqUQFLjYI1htQCBM661c?=
 =?us-ascii?Q?A738KZ1nti3CRrsQYCwDCyij3LwRtP4dTN6U9CegzjlS4qUZJWRLt30G0/tY?=
 =?us-ascii?Q?uovNaCGcgVBwcqVdpPTAl2RfQ+3JSMG4mTUyDJeQioH03nZ3QGZgHDRrNI8Z?=
 =?us-ascii?Q?mzhE/SlShPBCdcpP9wfSuUX5z+ukaxBqrakEWrdsydDG7mfB8TsYK2/WjGct?=
 =?us-ascii?Q?J+KFKoYP2vUqUulOkdEbKPIaZJVZFp5snQ7Av6ZDKIEpIuZXAp9UDSImMjfN?=
 =?us-ascii?Q?iwMbEkk19KuZMc/DECGSklbE/w+/pLS6j7p3xI5JRC996BJy5W2cGBuX8vox?=
 =?us-ascii?Q?0o01nG0tShpzweEpEqd09uKAVToaD7FOsItaw2FgoWnAxAzhWwumpt2KeDiA?=
 =?us-ascii?Q?Uk1B+xRs1wg0UpwWakQoZoZJU6PoaPhYCzrwWadbzYgUWifgSDvPuZUU2HKI?=
 =?us-ascii?Q?J25Fulr+0Ih2z8OOwO/6t335+iq+eAuCXstXie/NQheDcxHArDP3VEd6fkNF?=
 =?us-ascii?Q?FeXLIN9egcmooi3Y/ZSFGuYr+b5ZL2AAbfghyK4lTPLNzRRGK5jGTYFH5zmp?=
 =?us-ascii?Q?9P31IAfhgkxLJm1ExJOR6KqR00G9D7Rb8r1pwo27an/kG9mn1grTWow2vK4n?=
 =?us-ascii?Q?KOGpp3QB/3wHgIrlO0Iac6zTWQTd/WFKcUfT75Hzg60+y7rY92VDWj7MxZdQ?=
 =?us-ascii?Q?DwQv/DDaNg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR02MB6640.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adab7409-6689-46aa-ba93-08da1de01a60
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2022 06:29:17.6117
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J2iYzA0LAgN96S0n/LsAfSNpWdWwcR+eFDNPBpFBnx/nmHi18fTWfjt16THczuIl+zIWy9uZaQxvmSkzUnwFpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5082
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org



> -----Original Message-----
> From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> Sent: Friday, March 18, 2022 3:49 PM
> To: linux-edac@vger.kernel.org
> Cc: Michal Simek <michals@xilinx.com>; rric@kernel.org; bp@alien8.de;
> mchehab@kernel.org; tony.luck@intel.com; git <git@xilinx.com>;
> Shubhrajyoti Datta <shubhraj@xilinx.com>
> Subject: [PATCH v2] edac: synopsys: Fix the issue in reporting of the err=
or
> count
>=20
> Currently the error count from status register is being read which is not
> correct. Fix the issue by reading the count from the error count
> register(ERRCNT).
>=20
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> ---
If there are no further comments can the patch be  merged.

