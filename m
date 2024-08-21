Return-Path: <linux-edac+bounces-1710-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CCD99596F8
	for <lists+linux-edac@lfdr.de>; Wed, 21 Aug 2024 11:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 505A91F22681
	for <lists+linux-edac@lfdr.de>; Wed, 21 Aug 2024 09:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35C81C2DAA;
	Wed, 21 Aug 2024 08:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h2XCsGxT"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA601C2DA1;
	Wed, 21 Aug 2024 08:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724228437; cv=none; b=jCOBsqbGtwiNG4xsVbEaN8GeMvWXJgjKfSTBVDuN1oWej4R+4Ho4NNMn8RsnBFZNieeqgX94h1KkOgcHc7pDoU1BwmKgHaiblKo/8AkkUG0HUXgQjiLyCAqgvEn/CF1eATUwVJXaB2RUa6EJsn3iyfOzfZjLwfZs9Mn0YATkxdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724228437; c=relaxed/simple;
	bh=/KCb8OFN5/cjiyWJC8kvNgVUz8FhC5UXGxnpcTHn0FQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=THQd+5bIM49zXJXiBHlyZTOyX74PZboDACbTDxD3LOHjsTWdSOqRlFc2wMYRcmOfM1t/RyoSqHlhGXs+W8zxRTwO6mElHzWlTar7Qo65hkosJQ9wu5elwZeaxT5g/j+XfoeANTMG73xd8M14HJA+6NhmZtFjWF75QD8BK7UVtMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h2XCsGxT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71FD6C4AF0C;
	Wed, 21 Aug 2024 08:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724228437;
	bh=/KCb8OFN5/cjiyWJC8kvNgVUz8FhC5UXGxnpcTHn0FQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=h2XCsGxT55KYSo1bkmTdKOEbNyG4E8s98/EkXmTSrWBjltNkcaW0N80l9JwJK432f
	 sg4lKXwVlb37mcQMjbQtPC19TTWtIghZ3U40MEljfDEEdg6pi03kt0arBlZ7QFvtzZ
	 RWVRLji4xnROXhJtPT/2ELldp5itCkkY4RWfppdsskMaUOdyIT6ihqatNGtGHvzk11
	 Fxj61fc7qiNzzl9fJ1EL9oFw2AybwgvQxDzcZxXenqoOwtguUyxhQOFfKUgXNXZMsJ
	 HNUPnZc+SDGC4Wx5P97OGdNkGsVqelxVxYq0kbSnurB5Gew+Ff6uhjcF2lD05DNIPo
	 pmGU7RWNpfKsQ==
Message-ID: <de5ffcd8-0f2a-4cca-a7a0-0c4fc0158392@kernel.org>
Date: Wed, 21 Aug 2024 10:20:29 +0200
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] dt-bindings: EDAC for loongson memory controller
To: Zhao Qunqin <zhaoqunqin@loongson.cn>, chenhuacai@kernel.org,
 kernel@xen0n.name, bp@alien8.de, tony.luck@intel.com, james.morse@arm.com,
 mchehab@kernel.org, rric@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org
Cc: loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-edac@vger.kernel.org, devicetree@vger.kernel.org
References: <20240821064728.8642-1-zhaoqunqin@loongson.cn>
 <20240821064728.8642-3-zhaoqunqin@loongson.cn>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240821064728.8642-3-zhaoqunqin@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/08/2024 08:47, Zhao Qunqin wrote:
> From: zhaoqunqin <zhaoqunqin@loongson.cn>
> 
> Add: drivers/edac/loongson_edac.c
> 
> Signed-off-by: zhaoqunqin <zhaoqunqin@loongson.cn>

Please use full name, not login.

> ---
>  .../bindings/edac/loongson,ls-mc-edac.yaml    | 35 +++++++++++++++++++

Bindings are before users.

>  MAINTAINERS                                   |  7 ++++
>  2 files changed, 42 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/edac/loongson,ls-mc-edac.yaml
> 
> diff --git a/Documentation/devicetree/bindings/edac/loongson,ls-mc-edac.yaml b/Documentation/devicetree/bindings/edac/loongson,ls-mc-edac.yaml
> new file mode 100644
> index 000000000..29e5b8381
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/edac/loongson,ls-mc-edac.yaml
> @@ -0,0 +1,35 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/edac/loongson,ls-mc-edac.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Loongson Memory Controller EDAC
> +
> +maintainers:
> +  - Zhao Qunqin <zhaoqunqin@loongson.cn>
> +
> +description: |
> +  EDAC node is defined to describe on-chip error detection and correction for
> +  Loongson Memory Controller.
> +
> +properties:
> +
> +  compatible:
> +    const: loongson,ls-mc-edac

Missing soc part. And then adjust filename to match proper (new) compatible.

> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    edac: mc0@1fe00600 {

memory-controller@

and drop unused label.


> +        compatible = "loongson,ls-mc-edac";
> +        reg = <0x0 0x1fe00600 0x0 0x50>;
> +    };

Best regards,
Krzysztof


