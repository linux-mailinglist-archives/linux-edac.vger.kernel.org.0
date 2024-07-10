Return-Path: <linux-edac+bounces-1485-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A591992CBCE
	for <lists+linux-edac@lfdr.de>; Wed, 10 Jul 2024 09:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6E4D1C2290A
	for <lists+linux-edac@lfdr.de>; Wed, 10 Jul 2024 07:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B9057174F;
	Wed, 10 Jul 2024 07:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="RBZ1t4z+";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="T7x6sGhg"
X-Original-To: linux-edac@vger.kernel.org
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBACD535;
	Wed, 10 Jul 2024 07:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720595903; cv=none; b=LLzky3b//X6052/OzMSHK/JJhbl/qghLa/hdUqmz+VZ7bOzYO1WFdNIZx15YhvL2/UuJTVf8T3l6ky884azLgf3R0KUdwLznTd0hIzMFMAfysQRQqVQZl2ITH9dBkqETVmxNyCzClqsjKglfW9sYI+pxXQ+qBuum1Oy9nI4larE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720595903; c=relaxed/simple;
	bh=q1n3vhCEwT0L8KK1wY4qRJB02yVy4nxM8B2JsbUp65g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tK+3eZaLGSxiLlq27MM/RGXdF4qPvHI0aCfPLi1ku1UeJkkF9j06tsDDZHy4TuUlDk/cCrE4X4S6FJNLITuGbXANvjjXXgCzK4Wy/oal23cFL4pxmV1SH/NbK4RTb41d1Cnz2uH4pMU2XDEbJ3SHXifjpArk63hE55btc/pdxDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=RBZ1t4z+; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=T7x6sGhg reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1720595900; x=1752131900;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bzFdmN4YSMsYqNzg1gKeQE0QeWkldNu+KdO/Z6kO2Ok=;
  b=RBZ1t4z+w1rQnAR2NJdBXh8cT1G7rBf3I4AhdgFE99Km2Pgl3ABtcZW8
   2TWWUF4fuNmKTUlak4KQkvZs6OMndeYj9KpDvbrbSoRTXdeirjo6koMY6
   iKAXDZeMj/rSKAy199k6Rz0Rvv7SRxRYY97t+SOX76/Y1huxKuY7x739W
   KGXgdxJ0xRcHIR8lhljGhN8NhIsX6pmW1A+4xi2n42k6RCOsSDA0sYebI
   iSHN1KRqwjreo3JVJnMAgSbSjA0U/iIS5ZFEDCUDbZsHsvCBwn4SYsEvv
   Ix1UArZNJpTMdxBZvmYRD5HXbqcoyp/EE2gWBtVXiPIITv6p+Wv4vrkzy
   Q==;
X-CSE-ConnectionGUID: iBBx2iWjTXqVlKJTpMk04g==
X-CSE-MsgGUID: a3vuhXTYTue6VNz0KPa+jA==
X-IronPort-AV: E=Sophos;i="6.09,197,1716242400"; 
   d="scan'208";a="37831245"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 10 Jul 2024 09:18:17 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D9E26160B1D;
	Wed, 10 Jul 2024 09:18:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1720595893;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=bzFdmN4YSMsYqNzg1gKeQE0QeWkldNu+KdO/Z6kO2Ok=;
	b=T7x6sGhgYzu7QX5HNtiaCZ0KFg4oZ43vL8ZbpFnbdYSyQYxbNHc/IbZ2WLU/qBrYvulVlo
	j8prnJLSET50sm0dN0JVoe/Dz5uLVlvf2AsRqLoaGqupap+PHHDOpmfc/EUyLiQoSRKN0I
	M//on1iSYxik7leOemWKsOWxJjo51dF0qno35w7M3f7qqH0oIkCkV4IvrE3Tjem7XSGmqK
	O5fA2/SwsxX0Fjn3cPpMmXwOi9K3s0+1K1l7OeO0IolxQpIsm7YhWeOYI3QQuIa2RPPrgL
	yJWugsvPjdnsEp6gNyx6GxfBkxS8BrTFCl8FFmZQ8HEd71hwXS6YzAdDTZOhsA==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: York Sun <york.sun@nxp.com>, Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>, James Morse <james.morse@arm.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Robert Richter <rric@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, linux-arm-kernel@lists.infradead.org
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org, Borislav Petkov <bp@suse.de>, devicetree@vger.kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, Frank Li <Frank.Li@nxp.com>, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH 4/6] dt-bindings: memory: fsl: Add compatible string nxp, imx9-memory-controller
Date: Wed, 10 Jul 2024 09:18:16 +0200
Message-ID: <6068670.lOV4Wx5bFT@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20240709-imx95_edac-v1-4-3e9c146c1b01@nxp.com>
References: <20240709-imx95_edac-v1-0-3e9c146c1b01@nxp.com> <20240709-imx95_edac-v1-4-3e9c146c1b01@nxp.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Last-TLS-Session-Version: TLSv1.3

Hi Frank,

Am Dienstag, 9. Juli 2024, 22:23:05 CEST schrieb Frank Li:
> iMX9 memory controller is similar with other layerscape chips. But some
> register layout has a little bit difference, so add new compatible string
> 'nxp,imx9-memory-controller' for it.

Is this controller the same for all i.MX9 SoC? E.g. i.MX91, i.MX93,
i.MX95 and any future variants?

Best regards,
Alexander

> imx9 need two 'reg', one for DDR controller and the other is ECC inject
> engine register space. Keep the same restriction for other compatible
> string.
>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../bindings/memory-controllers/fsl/fsl,ddr.yaml   | 31 ++++++++++++++++=
+++++-
>  1 file changed, 30 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/memory-controllers/fsl/fsl=
,ddr.yaml b/Documentation/devicetree/bindings/memory-controllers/fsl/fsl,dd=
r.yaml
> index 84f778a99546b..e0786153eec73 100644
> --- a/Documentation/devicetree/bindings/memory-controllers/fsl/fsl,ddr.ya=
ml
> +++ b/Documentation/devicetree/bindings/memory-controllers/fsl/fsl,ddr.ya=
ml
> @@ -40,6 +40,7 @@ properties:
>            - fsl,p1021-memory-controller
>            - fsl,p2020-memory-controller
>            - fsl,qoriq-memory-controller
> +          - nxp,imx9-memory-controller
> =20
>    interrupts:
>      maxItems: 1
> @@ -51,13 +52,41 @@ properties:
>      type: boolean
> =20
>    reg:
> -    maxItems: 1
> +    items:
> +      - description: Controller register space
> +      - description: Inject register space
> +    minItems: 1
> +
> +  reg-names:
> +    items:
> +      - const: ctrl
> +      - const: inject
> +    minItems: 1
> =20
>  required:
>    - compatible
>    - interrupts
>    - reg
> =20
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - nxp,imx9-memory-controller
> +    then:
> +      properties:
> +        reg:
> +          minItems: 2
> +        reg-names:
> +          minItems: 2
> +    else:
> +      properties:
> +        reg:
> +          maxItems: 1
> +        reg-names: false
> +
>  additionalProperties: false
> =20
>  examples:
>=20
>=20


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



