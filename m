Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C15B41AAB09
	for <lists+linux-edac@lfdr.de>; Wed, 15 Apr 2020 17:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409954AbgDOOyT (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 15 Apr 2020 10:54:19 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:24640 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2407940AbgDOOyR (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Wed, 15 Apr 2020 10:54:17 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03FEq27g002592;
        Wed, 15 Apr 2020 07:54:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=4Fqc+5SBnjdzjN4AU4z/KoWDhnB0Y14SiQPORLX0whs=;
 b=Sb4XyPfyNJ4ErkgZaolm6ksPcv7Vrk8Bh2gvjE85E3GmOGKR1VN3Cbrtmohw5bg4bpmD
 mjoczWScmnCfmxaMs12sK9vVvdsRqO4dTG9dz7GfYofYwBw92NBz5B36T3V653+gYXIa
 0rCAd5cBfFV0R9hMnjBqrK9mDqacAkddIZ08xlX64C0Licgfc1D3uqOC2S2nuRZAvlTL
 HinfOE9syPk6slqLPPWcqujH7JDNOBkGkvOFpBlKtOPDoUQ+r7dz77Xm55zc+KNEDTvP
 d/FZySYnK+AhTINBqDIa4Exq3e1kh4JRDA6+X3OxqRvp/2B8q70TjJyXrYHbVnEw6GWy Hg== 
Received: from nam04-bn3-obe.outbound.protection.outlook.com (mail-bn3nam04lp2050.outbound.protection.outlook.com [104.47.46.50])
        by mx0a-0014ca01.pphosted.com with ESMTP id 30dn95u5xs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Apr 2020 07:54:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j9gjhfpk7Dz3VwYRDuQ/fDLpDc5OqeDzfObkqKzIKaRxH5sNqWOY6PbqQ8qHex/T3SY+9K/0FOOjHIweFOsj6gcRFaoetq+9abMQ5uQuY1KDl1v0OikO08/VKYWEogKC424HLqNhpFUER/+W+h9BHnL6flGvQW/M7xtBgeDo3OWqw/iE1cz91n69cFoZLBnfhfwvFjU7E3PIN62+v4r7clV7W+2C/E5lPufBayECCsXRctPk8zZ3nvReQQflB0ljSnVT1m0iDu7w5ii85tvxXFBWlVB08T1PlJaJsREGuSu/xM8emOGugHLzQKoqEmitTSMTMmmWp93g6X5Hf+OAPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Fqc+5SBnjdzjN4AU4z/KoWDhnB0Y14SiQPORLX0whs=;
 b=GAHhJDx6OqUWI8bXxMAEd7uzy4VI42bGpanMDO5L7G++2sj1N0VSXrjkzofFH3BQ6bVui5Wo/Mx2BQtrBo0E/Biimceq6HuotyW1Uav5L+QS1pWqmMLxxx2rHlz3bskqUZU+e9TyW8o5Ge7M4AK2TUUL/R3s8hqDVKu5v+H31TiAscNP6vKQtaC6RJtnGkqQM7l1+u29bf1MiMV9D4mVh1iREawAjtp+9UjNev3KT9VEFcjym2JYl0Wlyksze6qyuWaaM8C6zUwymUaqFQSKCZ8ipMGDaWVPddnAsB4bvsYn2XwG+QFP48C7c6K77WYQBacVaMzqlR+/vFvoynlCeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Fqc+5SBnjdzjN4AU4z/KoWDhnB0Y14SiQPORLX0whs=;
 b=j4nkaoQxwf43bTXcxRw2Un0heEQMpY4Ar+CR3E0iUUZTD9zD7A7SMlQG9vDQ7yym/VNSAF4+M7fe7c9kQc9Y9snmsg+JVq6OVHXJ92GCIIywBLMhgJBBFodrcbtTiYhMl0PHvMTQZPqIjAOzvyYVvEc2Nai1xQR7zKVYiwsZJ7A=
Received: from CH2PR07MB7190.namprd07.prod.outlook.com (2603:10b6:610:a6::9)
 by CH2PR07MB6646.namprd07.prod.outlook.com (2603:10b6:610:2a::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.26; Wed, 15 Apr
 2020 14:54:00 +0000
Received: from CH2PR07MB7190.namprd07.prod.outlook.com
 ([fe80::54cc:7e45:34a4:dead]) by CH2PR07MB7190.namprd07.prod.outlook.com
 ([fe80::54cc:7e45:34a4:dead%5]) with mapi id 15.20.2900.026; Wed, 15 Apr 2020
 14:54:00 +0000
From:   Dhananjay Vilasrao Kangude <dkangude@cadence.com>
To:     Rob Herring <robh@kernel.org>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Milind Parab <mparab@cadence.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH v3 1/2] dt-bindings: edac: Add cadence ddr mc support
Thread-Topic: [PATCH v3 1/2] dt-bindings: edac: Add cadence ddr mc support
Thread-Index: AQHWDBU2kEqZVlE2RUO5NQk0ZDbUU6h5VpeAgAD7uFA=
Date:   Wed, 15 Apr 2020 14:54:00 +0000
Message-ID: <CH2PR07MB719089038FB19B7FAEF23ED1CDDB0@CH2PR07MB7190.namprd07.prod.outlook.com>
References: <20200406131341.1253-1-dkangude@cadence.com>
 <20200406131341.1253-2-dkangude@cadence.com> <20200414234947.GA24554@bogus>
In-Reply-To: <20200414234947.GA24554@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcZGthbmd1ZGVcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy1lZDY3YzRlYS03ZjI4LTExZWEtYWU4Ny1hNDRjYzg0ZmJjNTNcYW1lLXRlc3RcZWQ2N2M0ZWMtN2YyOC0xMWVhLWFlODctYTQ0Y2M4NGZiYzUzYm9keS50eHQiIHN6PSIzODA3IiB0PSIxMzIzMTQzNjAzNTY4Mjg2MDAiIGg9ImJqYWtBa0xUcGxvNitiSHFjVS9BUUYvaDQ1az0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: true
x-originating-ip: [59.145.174.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c3a3a492-10e9-4736-3e4f-08d7e14cd4ec
x-ms-traffictypediagnostic: CH2PR07MB6646:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR07MB664662762F84C6093CC279F9CDDB0@CH2PR07MB6646.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0374433C81
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR07MB7190.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(376002)(39860400002)(136003)(396003)(346002)(366004)(36092001)(186003)(33656002)(76116006)(8936002)(5660300002)(71200400001)(86362001)(66946007)(9686003)(52536014)(6916009)(4326008)(81156014)(478600001)(26005)(8676002)(6506007)(2906002)(66446008)(64756008)(53546011)(54906003)(66476007)(66556008)(7696005)(55016002)(316002);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dLqcBcRJ+hIhJ7wgr/J34+3A4Eu0QhZtcpOogRpxv6y1tACiXCLhgZU/0J8gU+pcczZS5uPNU//HVOWxBoRBpNvWMJdhBxcFXEplL090H3PbqHuJJzNbQ8WwWtwtC8VjHRhkSusUNH6Vc8IyXebIkO2BHZe2Y3b/5kb+jZn1St0mjol/XzNT/CF3WKqJiZBaXFWITOIRrvwncVETqpeFpi3lJZ59BW5J7XvMKnh6I513VaaWeIBYYLJYzYTUVAUWWD5a4Z5m07BX5w297m5U8LMYytxJQXrgN0hOhQdIC11UwQ92lHtl/tKjaowzPcgPHPiZJdziOZgPfZFM7VM0WsqvoTio7TCEDphV0TzoctQgDWugq3VEsFj0rTKXp2g0i63aVXbPisabYDaKAfL04U6ekOy2svinnbAqVDCZ2VYYML8/oO98GNvsCBmHx228OlmzAnxgkNyenr1kiTsYK3qRCstdLUx+Ua9AJMWQBw0NaYsZrxwxruYSktc/2uTWWTundnk9eVqlvZePP05bNV8qWadSeoiWibZUhpD3CeoObuU7bz8SGKhyKHFop8cmeqrGv04oJ/Dx0Tln95FzYg==
x-ms-exchange-antispam-messagedata: ghRTzivRW3Wmn5dzV7zKI9f/IvdEaZWWZL48kYRrXAZjwgrjEMxRVoq68VhyTngoJWWCzXQDVVMT81SlDgHtkUBHcKOrUcQGUci6AmrwfOWmeZsiDfc0WrbN1wJtBX2HFdbSzrYjRiaHqc0tkaGYKg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3a3a492-10e9-4736-3e4f-08d7e14cd4ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2020 14:54:00.0767
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mCOYUNpPj4wvTL6Zo0Qo+5FQzhL8bZs/35C0U7WiXbDI6TRWR36sW5KoBz3JrfUj8+hqSLelQMdMt4HxgojrvmJa7OZl5jeAtIadM/JLdp0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR07MB6646
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-15_05:2020-04-14,2020-04-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxscore=0
 impostorscore=0 bulkscore=0 clxscore=1011 lowpriorityscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004150111
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org



> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Wednesday, April 15, 2020 5:20 AM
> To: Dhananjay Vilasrao Kangude <dkangude@cadence.com>
> Cc: linux-edac@vger.kernel.org; bp@alien8.de; mchehab@kernel.org;
> tony.luck@intel.com; james.morse@arm.com; linux-kernel@vger.kernel.org;
> Milind Parab <mparab@cadence.com>; devicetree@vger.kernel.org
> Subject: Re: [PATCH v3 1/2] dt-bindings: edac: Add cadence ddr mc support
>=20
> EXTERNAL MAIL
>=20
>=20
> On Mon, Apr 06, 2020 at 03:13:40PM +0200, Dhananjay Kangude wrote:
> > Add documentation for cadence ddr memory controller EDAC DTS bindings
> >
> > Signed-off-by: Dhananjay Kangude <dkangude@cadence.com>
> > ---
> >  .../devicetree/bindings/edac/cdns,ddr-edac.yaml    |   47
> ++++++++++++++++++++
> >  1 files changed, 47 insertions(+), 0 deletions(-)  create mode 100644
> > Documentation/devicetree/bindings/edac/cdns,ddr-edac.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/edac/cdns,ddr-edac.yaml
> > b/Documentation/devicetree/bindings/edac/cdns,ddr-edac.yaml
> > new file mode 100644
> > index 0000000..30ea757
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/edac/cdns,ddr-edac.yaml
> > @@ -0,0 +1,47 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause) %YAML 1.2
> > +---
> > +$id:
> > +https://urldefense.com/v3/__http://devicetree.org/schemas/edac/cdns,d
> > +dr-
> edac.yaml*__;Iw!!EHscmS1ygiU1lA!T49K56JzhGnA7nxu4mq55aDfl80QsXPj-l
> > +Egtf_PILMzq2Np6NqhLRXeTNuBLx0$
> > +$schema:
> > +https://urldefense.com/v3/__http://devicetree.org/meta-schemas/core.y
> > +aml*__;Iw!!EHscmS1ygiU1lA!T49K56JzhGnA7nxu4mq55aDfl80QsXPj-
> lEgtf_PILM
> > +zq2Np6NqhLRXe69d40qY$
> > +
> > +title: Cadence DDR IP with ECC support (EDAC)
> > +
> > +description:
> > +  This binding describes the Cadence DDR/LPDDR IP with ECC feature
> > +enabled
> > +  to detect and correct CE/UE errors.
> > +
> > +maintainers:
> > +  - Dhananjay Kangdue <dkangude@cadence.com>
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - cdns,ddr4-mc
>=20
> Surely there's more than 1 version?

[Dhananjay Kangude] No, as of now we have only one version of hardware modu=
le.=20
I will change the property with items instead of enum.
>=20
> > +
> > +  reg:
> > +    minItems: 1
> > +    maxItems: 2
> > +    items:
> > +      - description:
> > +          Register block of DDR/LPDDR apb registers up to mapped area.
> > +          Mapped area contains the register set for memory controller,
> > +          phy and PI module register set doesn't part of this mapping.
>=20
> doesn't part of this mapping?
>=20
[Dhananjay Kangude] In case of combo IP, controller and phy module are toge=
ther.=20
But ecc doesn't have any dependencies on phy module so we can exclude phy m=
odule .
> Need a description for the 2nd region.

[Dhananjay Kangude] Removed maxItems property. We don't have another region=
 to access.
fix will release in next version
>=20
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    edac: edac@fd100000 {
>=20
> memory-controller@
[Dhananjay Kangude] ] memory-controller might not the appropriate name.=20
the driver module is only focused on ecc not on actual memory-controller fu=
nctionality.
>=20
> > +        compatible =3D "cdns,ddr4-mc-edac";
>=20
> Doesn't match.
[Dhananjay Kangude] fixed. Changes will be part of next version.
>=20
> > +        reg =3D <0xfd100000 0x4000>;
> > +        interrupts =3D <0x00 0x01 0x04>;
> > +    };
> > +...
> > --
> > 1.7.1
> >
