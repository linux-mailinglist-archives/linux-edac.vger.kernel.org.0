Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD142854E
	for <lists+linux-edac@lfdr.de>; Thu, 23 May 2019 19:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731264AbfEWRvz (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 23 May 2019 13:51:55 -0400
Received: from mail-eopbgr730090.outbound.protection.outlook.com ([40.107.73.90]:11392
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730928AbfEWRvy (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 23 May 2019 13:51:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=yOwyZSUksOx9KxLIo5CrD+4bl8GF+yuZ+EOu9t2BKcr17jHiH5Q3U5fCLJjuSDqQdwl3LFGCzkr1Jro5KO2wz90jP1j8SS5LvZo8akHDp18STSjx/+YKJS/LCm47SziKCokc92C6CnJPibWXMzuVU0QO4GyOdWZ5bK0OGwB5wco=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O1gtWwZvKHrCTwBPtZVN+DvvUZS0a8xh+/uzA+bC2nk=;
 b=uAHTmHYPDvhpZZo4rJPjh0OCnnOz8KGT7yagN+cj+X8EEivi6hbFL2tQi+cettfNID6dex7U3Mb19FPhxK3/gW6vKlDYwBNW2tkUNvQD3noyQmmFanuJ0qTMPhDKLowL7VphYwJEJJhHx1XpeaYHr8qVoIjInj3f4R9kamc9WjQ=
ARC-Authentication-Results: i=1; test.office365.com
 1;spf=none;dmarc=none;dkim=none;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O1gtWwZvKHrCTwBPtZVN+DvvUZS0a8xh+/uzA+bC2nk=;
 b=kdt5X+qn6hWsnOW6I5P043tmlmqErOJwmHmoOgrfIdfJJ3jmglhYx3oTAZps7b2/dsM+Jhy6kmtwRKVpgA6Byl81LZ6pe0IBlpZNKskH8mefRgF/TvxRJPRsKzwCs/Qbv7Qo5Soa2FifR2/4hJDCFgYZwZHytkEScCFe5WMCH6k=
Received: from BYAPR21MB1319.namprd21.prod.outlook.com (2603:10b6:a03:115::9)
 by BYAPR21MB1191.namprd21.prod.outlook.com (2603:10b6:a03:105::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1922.3; Thu, 23 May
 2019 17:51:49 +0000
Received: from BYAPR21MB1319.namprd21.prod.outlook.com
 ([fe80::e9a9:224d:3961:2088]) by BYAPR21MB1319.namprd21.prod.outlook.com
 ([fe80::e9a9:224d:3961:2088%8]) with mapi id 15.20.1943.006; Thu, 23 May 2019
 17:51:49 +0000
From:   "Lei Wang (BSP)" <Wang.Lei@microsoft.com>
To:     Mark Rutland <mark.rutland@arm.com>,
        Lei Wang <leiwang_git@outlook.com>
CC:     "bp@alien8.de" <bp@alien8.de>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        Rui Zhao <ruizhao@microsoft.com>,
        Hang Li <hangl@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: RE: [PATCH v3 1/2] dt-bindings: edac: arm-dmc520.txt
Thread-Topic: [PATCH v3 1/2] dt-bindings: edac: arm-dmc520.txt
Thread-Index: AQHVC5AR4+AcLYu1eESQ1uQyoWKNiaZ4+muAgAAKjAA=
Date:   Thu, 23 May 2019 17:51:49 +0000
Message-ID: <BYAPR21MB1319BC4D079B918AB038A4D590010@BYAPR21MB1319.namprd21.prod.outlook.com>
References: <CY1PR0401MB1244062C1738B09D6100F202860A0@CY1PR0401MB1244.namprd04.prod.outlook.com>
 <20190523165841.GD7523@lakrids.cambridge.arm.com>
In-Reply-To: <20190523165841.GD7523@lakrids.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=lewan@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-05-23T17:51:47.9288836Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=12189b5c-1702-4376-aa08-110460eab1f4;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Wang.Lei@microsoft.com; 
x-originating-ip: [2001:4898:80e8:0:74f8:b538:8cb0:8ca0]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ec2f4537-2761-43cc-1b08-08d6dfa754b8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:BYAPR21MB1191;
x-ms-traffictypediagnostic: BYAPR21MB1191:
x-microsoft-antispam-prvs: <BYAPR21MB1191D206046F24D18444C6D090010@BYAPR21MB1191.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 00462943DE
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(376002)(136003)(346002)(396003)(199004)(189003)(13464003)(8990500004)(6246003)(22452003)(10290500003)(107886003)(5660300002)(53936002)(52536014)(76176011)(7696005)(4326008)(2906002)(102836004)(68736007)(52396003)(6116002)(99286004)(6506007)(53546011)(229853002)(72206003)(86612001)(8676002)(486006)(478600001)(54906003)(25786009)(256004)(110136005)(6436002)(316002)(8936002)(186003)(55016002)(10090500001)(11346002)(9686003)(7736002)(476003)(446003)(305945005)(14454004)(71190400001)(71200400001)(81156014)(46003)(81166006)(86362001)(73956011)(66946007)(66446008)(76116006)(33656002)(64756008)(66556008)(66476007)(74316002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR21MB1191;H:BYAPR21MB1319.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: NRZGK2QaAq79EuKfAN4cXWfPDYw2vu/o6hgBvfJy5ULU9ICrN3P+llWqP/lt//h8XD2vGGpqt+Dxf1Auc+apTP66+i8jKDhuni7RqJB6HLvgAlJn+dQqo6J9gxpUgnglw2z9/Sc0mPD7RN+7+Dx8aN32F8hNlWyANkVAhE9xONlOH4t6pRTdMgoSgxGSE6PfwK83J/UvP2o81MBMpzeOYEfZdsJ//diRDFpdgpf19KrD29G3udyFIH9XAlTOearUS71zxg+gKGLpkwZB59MlToDIXqe/JxFvdWjmvzoGut7UsKuIUckWeJ/z2E5wlGLu2XiZpeK3hskA3PBoF7f7gGeYxnuKfF8gbsmkP11IwiXyBTlh5E42pLk7b4Cjvfa46ucxUE1R2MggdPtGa94Txx2tXxOvzh7/HYkyH6tMxDk=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec2f4537-2761-43cc-1b08-08d6dfa754b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2019 17:51:49.1715
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lewan@microsoft.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR21MB1191
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

(+Rui/Hang/Sasha)

Hi Mark, please see inline with "[Lei]" tag. Thanks! -Lei

-----Original Message-----
From: Mark Rutland <mark.rutland@arm.com>=20
Sent: Thursday, May 23, 2019 9:59 AM
To: Lei Wang <leiwang_git@outlook.com>
Cc: bp@alien8.de; james.morse@arm.com; robh+dt@kernel.org; devicetree@vger.=
kernel.org; linux-kernel@vger.kernel.org; linux-edac@vger.kernel.org; Lei W=
ang (BSP) <Wang.Lei@microsoft.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: edac: arm-dmc520.txt

On Thu, May 16, 2019 at 02:35:47AM +0000, Lei Wang wrote:
> From: Lei Wang <leiwang_git@outlook.com>
>=20
> This is the device tree bindings for new EDAC driver dmc520_edac.c.
>=20
> Signed-off-by: Lei Wang <leiwang_git@outlook.com>
> ---
>  .../devicetree/bindings/edac/arm-dmc520.txt        | 26 ++++++++++++++++=
++++++
>  1 file changed, 26 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/edac/arm-dmc520.txt
>=20
> diff --git a/Documentation/devicetree/bindings/edac/arm-dmc520.txt b/Docu=
mentation/devicetree/bindings/edac/arm-dmc520.txt
> new file mode 100644
> index 0000000..71e7aa3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/edac/arm-dmc520.txt
> @@ -0,0 +1,26 @@
> +* ARM DMC-520 EDAC node
> +
> +Required properties:
> +- compatible		: "brcm,dmc-520", "arm,dmc-520".
> +- reg			: Address range of the DMC-520 registers.
> +- interrupts		: DMC-520 interrupt numbers. The example below specifies
> +			  two interrupt lines for dram_ecc_errc_int and
> +			  dram_ecc_errd_int.
> +- interrupt-config	: This is an array of interrupt masks. For each of th=
e
> +			  above interrupt line, add one interrupt mask element to
> +			  it. That is, there is a 1:1 mapping from each interrupt
> +			  line to an interrupt mask. An interrupt mask can represent
> +			  multiple interrupts being enabled. Refer to interrupt_control
> +			  register in DMC-520 TRM for interrupt mapping. In the example
> +			  below, the interrupt configuration enables dram_ecc_errc_int
> +			  and dram_ecc_errd_int. And each interrupt is connected to
> +			  a separate interrupt line.

Generally we use interrupt-names to distinguish interrupts.

Do you really have arbitary subsets of lines muxed together?

-----------------------------------------------
[Lei] Yes it is possible to mux multiple interrupt sources into one interru=
pt line for dmc520. For example, in this particular brcm implementation,=20

Line 841: source dram_ecc_errc_int
Line 843: source dram_ecc_errd_int
Line 839: source dram_ecc_errc_int and dram_ecc_errd_int

There are two possibilities for implementing ecc counts for ce/ue. And we c=
hose to use the single source line. But it's possible to implement using th=
e combined-source line too. This dt binding can support both by modifying t=
he properties.
-------------------------------------------------

Thanks,
Mark.

> +
> +Example:
> +
> +dmc0: dmc@200000 {
> +	compatible =3D "brcm,dmc-520", "arm,dmc-520";
> +	reg =3D <0x200000 0x80000>;
> +	interrupts =3D <0x0 0x349 0x4>, <0x0 0x34B 0x4>;
> +	interrupt-config =3D <0x4>, <0x8>;
> +};
> --=20
> 2.7.4
>=20
