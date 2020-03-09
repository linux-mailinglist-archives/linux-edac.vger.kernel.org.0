Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4AA317DB6A
	for <lists+linux-edac@lfdr.de>; Mon,  9 Mar 2020 09:44:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbgCIIos (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 9 Mar 2020 04:44:48 -0400
Received: from mail-mw2nam12on2075.outbound.protection.outlook.com ([40.107.244.75]:6235
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726360AbgCIIos (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 9 Mar 2020 04:44:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R3fE9ELvfle4XZWNLJYmxcQazeEw5c1YN6xGw/24flpQWetun8cmVMH++Wyae1/wkxiGZQ/Im8Z1Bj4TlJcLqxxXWCLcf4+CAxeiehP+Z5EL+Z4/Ej8N0G23+Lmf+VhFNICUeYXI62BJqK8sEzwtDIL044p+F6FyTTSmjq+WtqGQd/Z9tOQskFlTzIRDehppUckeKjkD3HLhL+EIuSK6oObtOlJlqc1DSEHG0VAIrzqElo67ZhnhiUv6NPTvn4Cs+E8QfcqJdwvvlvYOC2zpen+MPA/EYi/MYasrlADaE028esAv2dOdszJdxnoVwbIaKcycwTcmR9kDjTE9ZyKr6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4vd9WVY/K1mKhb5pvx8kTMBR3MH10GFhE2aSaSkj5SU=;
 b=QhA2w/bTxY/E/tJ8Zz6V8B4xzWrCrB0ht5zpG9ij5y0Ks4a8gesrmxF8SDmh6fcwPgkSE+PlxQh8vTD1BEtxgcntj7C4VlVHKxn14fd+rjyWm9Ckha2vCvz6Gq2AAKLbViHz4s5bl6LE11SCQO7nYaKsvuqRwm/gMbBcCrVXETpWEiRmtH5V5qAn+SnpgQgaibFVpOcq3eQ3gRKw8IXtOGC3fcdI5MSF2ABvZ3HucWhbfpvLSYuyV5kOjkqdf0VplMg8BMGnUP545sHV5jGat/PkuD9WwT2ldGf6YHPogn2Mx6rVWo3Cot21HZpn/oR0P/kjUZli7TnJbkXSnwtNzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4vd9WVY/K1mKhb5pvx8kTMBR3MH10GFhE2aSaSkj5SU=;
 b=rnAYiiziKiZSHNIVPF33+s2WjNYrXyoQxavqwq5RHsMOwzmfdwaradvy06gADcboMvigx3LXi8QIrgGQ4Aua+DhUOhbo4JTYmbqJSo9D6LRP+EdG8S5jMGA/Aq1069LYOhdXnsk41KsM6rSPMY+eQqyEXno5DcNlFS9tHTDopY0=
Received: from DM6PR02MB4426.namprd02.prod.outlook.com (2603:10b6:5:22::28) by
 DM6PR02MB6541.namprd02.prod.outlook.com (2603:10b6:5:20b::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.17; Mon, 9 Mar 2020 08:44:44 +0000
Received: from DM6PR02MB4426.namprd02.prod.outlook.com
 ([fe80::2458:ae1:e813:f217]) by DM6PR02MB4426.namprd02.prod.outlook.com
 ([fe80::2458:ae1:e813:f217%6]) with mapi id 15.20.2793.013; Mon, 9 Mar 2020
 08:44:44 +0000
From:   Manish Narani <MNARANI@xilinx.com>
To:     Sherry Sun <sherry.sun@nxp.com>, "bp@alien8.de" <bp@alien8.de>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "rrichter@marvell.com" <rrichter@marvell.com>,
        Michal Simek <michals@xilinx.com>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "frank.li@nxp.com" <frank.li@nxp.com>
Subject: RE: [PATCH v2] EDAC: synopsys: Fix the wrong call of pinf->col
 parameter
Thread-Topic: [PATCH v2] EDAC: synopsys: Fix the wrong call of pinf->col
 parameter
Thread-Index: AQHV7d35tp+sKUPo50Cn2nONmd7VuKhAAVCw
Date:   Mon, 9 Mar 2020 08:44:44 +0000
Message-ID: <DM6PR02MB44264FE7166FB2D23D4B4503C1FE0@DM6PR02MB4426.namprd02.prod.outlook.com>
References: <1582856183-5007-1-git-send-email-sherry.sun@nxp.com>
In-Reply-To: <1582856183-5007-1-git-send-email-sherry.sun@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=MNARANI@xilinx.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [157.44.130.49]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 76693ed5-3f7e-41f2-eb24-08d7c4061dbb
x-ms-traffictypediagnostic: DM6PR02MB6541:|DM6PR02MB6541:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR02MB65411580FEEC4AF33A370973C1FE0@DM6PR02MB6541.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2331;
x-forefront-prvs: 0337AFFE9A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(366004)(376002)(346002)(396003)(189003)(199004)(52536014)(26005)(9686003)(6636002)(186003)(7696005)(5660300002)(7416002)(44832011)(64756008)(66476007)(66556008)(66446008)(33656002)(4326008)(66946007)(76116006)(55016002)(478600001)(4744005)(316002)(2906002)(110136005)(54906003)(53546011)(71200400001)(81156014)(8676002)(6506007)(81166006)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB6541;H:DM6PR02MB4426.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MkfWPj0v++J6L4jQnCtPjlPIrL5teOjqdojqoBIRgXWbbNDVQ7qhw7yR17UPBahRAOpI/lvkawkmLdVLE8ZUu+ByWPUeoaT+aPCIGam0Fp0/HP4EmE0jAdfhPPSnZIle0UP76HONlRCQOL3zH/56gTeb4wuyzgInRrvOqq1piEGJ7kxdSer33nvaKekNOjRdFM55i5jDw2p9RBxgs9LYSK3vGofeUmX2Uf0KVhKBQhQsy00gXeikURWlVAqRYFBkr1a5TXikZ3fCfk5Gw1mZVoQlrVe/AUzJUdG9dTzA1xBuLqPWP79PWHIoq/vJlROiN6y9nviIc89HBnjFiosqXkYGYeXVQ5yfwpKR78X1iVDq+276THdwcqkWbNq3zsFig1wTdvR5i7dww1mhQUGjBF7d3QJP5fylWCrw3NVEigD0p6IAvlutpq1VsdmdqbFD
x-ms-exchange-antispam-messagedata: DxGYRLcitdUbY228QvZ/6nvVDYM0Vd9JmnDiE1X03wMqAcDd3sttaoHnQ1A1Gz2UNVXNSbK5NUHAzr2fVQ7f5oNm57WiAAZ5TKbTqJi452a7MHc3CV5Fe9zVAPjlzORVXWLbomfq8a1zZd3Nip5RLA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76693ed5-3f7e-41f2-eb24-08d7c4061dbb
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2020 08:44:44.2717
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q3wEnhv2FPMFfDDUAY0V3bojxWi8u84Io4MA5jqO6LcwBZbpKQtuDRAvW4opWJsURDR/3gGGTe987qLOOF/rQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6541
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi,

> -----Original Message-----
> From: Sherry Sun <sherry.sun@nxp.com>
> Sent: Friday, February 28, 2020 7:46 AM
> To: bp@alien8.de; mchehab@kernel.org; tony.luck@intel.com;
> james.morse@arm.com; rrichter@marvell.com; Michal Simek
> <michals@xilinx.com>; Manish Narani <MNARANI@xilinx.com>
> Cc: linux-edac@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> imx@nxp.com; frank.li@nxp.com
> Subject: [PATCH v2] EDAC: synopsys: Fix the wrong call of pinf->col param=
eter
>=20
> Since ZynqMP platform call zynqmp_get_error_info() function to get ce/ue
> information. In this function, pinf->col parameter is not used, this
> parameter is only used by Zynq platforme in zynq_get_error_info(). So
> here pinf->col should not be called and printed for ZynqMP, need remove
> it.
>=20
> Fixes: b500b4a029d57 ("EDAC, synopsys: Add ECC support for ZynqMP DDR
> controller")
> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>

Reviewed-by: Manish Narani <manish.narani@xilinx.com>

Thanks,
Manish
