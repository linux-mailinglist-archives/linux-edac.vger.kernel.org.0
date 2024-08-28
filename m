Return-Path: <linux-edac+bounces-1740-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB61961C17
	for <lists+linux-edac@lfdr.de>; Wed, 28 Aug 2024 04:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF1EF1C231CC
	for <lists+linux-edac@lfdr.de>; Wed, 28 Aug 2024 02:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D910254656;
	Wed, 28 Aug 2024 02:25:06 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 910EB11CBD;
	Wed, 28 Aug 2024 02:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724811906; cv=none; b=ZJ4+Bf3AqMA2H4ykotB9a15Fs3gd+KjK1zl66zo4aEzVCknBh2Vo337zuzsHmwNlhkZSUFQdO0yCqoHrsqxrAUncLc6dNIUdlBeYZNWVm/nM+o7Tuo2rIHmQvXu6+/HgJ6ZtxoIvitJVfruMJxgNDVen2PR6cIOoSK+kETXIhHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724811906; c=relaxed/simple;
	bh=B5dtz9Yqh1A1+UtV12K1RcsbRpJNT05gSeVQzG9YFqU=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=tMmvTQUADSQX9x+yx7NGNWkYvxSjBkJgbgdB9v9DgrIURhbZXXMJXkGFo+tI5oQg6WEGB/5UI/++EvyeBWr4WZTYkJYt4fftHz3gwiKOcTFins7P/hZnsnWjftSNL46vMTXO9JDo5pa3uILL3f/JRjpwOQAqtOxPtO8R6EXn5Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.164])
	by gateway (Coremail) with SMTP id _____8AxSZp8is5mA1EiAA--.32384S3;
	Wed, 28 Aug 2024 10:25:00 +0800 (CST)
Received: from [10.20.42.164] (unknown [10.20.42.164])
	by front1 (Coremail) with SMTP id qMiowMAxE+B4is5mChwlAA--.41799S2;
	Wed, 28 Aug 2024 10:24:58 +0800 (CST)
Subject: Re: [PATCH v1 2/2] dt-bindings: EDAC for loongson memory controller
To: Krzysztof Kozlowski <krzk@kernel.org>, chenhuacai@kernel.org,
 kernel@xen0n.name, bp@alien8.de, tony.luck@intel.com, james.morse@arm.com,
 mchehab@kernel.org, rric@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org
Cc: loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-edac@vger.kernel.org, devicetree@vger.kernel.org
References: <20240821064728.8642-1-zhaoqunqin@loongson.cn>
 <20240821064728.8642-3-zhaoqunqin@loongson.cn>
 <de5ffcd8-0f2a-4cca-a7a0-0c4fc0158392@kernel.org>
From: Zhao Qunqin <zhaoqunqin@loongson.cn>
Message-ID: <eaeb61e0-ab13-c33f-a42e-c592ef345efa@loongson.cn>
Date: Wed, 28 Aug 2024 10:24:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <de5ffcd8-0f2a-4cca-a7a0-0c4fc0158392@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:qMiowMAxE+B4is5mChwlAA--.41799S2
X-CM-SenderInfo: 52kd01pxqtx0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxZw1DKFy7Kw1DAw4kZw17twc_yoW5Xr17pr
	n3Aan5Jryjqr1xGrs0gFy8JFWrt348J3ZrJrsrt3W7JFyq9F1YqFya9ryjgFn5Ar48Xry3
	ZFyfWw429F47ArXCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r12
	6r1DMcIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr4
	1lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxG
	rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUXVWUAwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j5fHUUUU
	UU=


在 2024/8/21 下午4:20, Krzysztof Kozlowski 写道:
> On 21/08/2024 08:47, Zhao Qunqin wrote:
>> From: zhaoqunqin <zhaoqunqin@loongson.cn>
>>
>> Add: drivers/edac/loongson_edac.c
>>
>> Signed-off-by: zhaoqunqin <zhaoqunqin@loongson.cn>
> Please use full name, not login.
>
>> ---
>>   .../bindings/edac/loongson,ls-mc-edac.yaml    | 35 +++++++++++++++++++
> Bindings are before users.
dt-bindings is 0001-*.patch and driver is 0002-*.patch ?
>
>>   MAINTAINERS                                   |  7 ++++
>>   2 files changed, 42 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/edac/loongson,ls-mc-edac.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/edac/loongson,ls-mc-edac.yaml b/Documentation/devicetree/bindings/edac/loongson,ls-mc-edac.yaml
>> new file mode 100644
>> index 000000000..29e5b8381
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/edac/loongson,ls-mc-edac.yaml
>> @@ -0,0 +1,35 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/edac/loongson,ls-mc-edac.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Loongson Memory Controller EDAC
>> +
>> +maintainers:
>> +  - Zhao Qunqin <zhaoqunqin@loongson.cn>
>> +
>> +description: |
>> +  EDAC node is defined to describe on-chip error detection and correction for
>> +  Loongson Memory Controller.
>> +
>> +properties:
>> +
>> +  compatible:
>> +    const: loongson,ls-mc-edac
> Missing soc part. And then adjust filename to match proper (new) compatible.

ls3c5000l, ls3c5000, ls3d5000, ls3a6000 and ls3c6000 are compatible with 
ls3a5000.

Can i write compatible string this way:

properties:
   compatible:
     oneOf:
       - enum:
           - loongson,ls3a5000-mc-edac
       - items:
           - enum:
               - loongson,ls3c5000l-mc-edac
               - loongson,ls3c5000-mc-edac
               - loongson,ls3d5000-mc-edac
               - loongson,ls3a6000-mc-edac
               - loongson,ls3c6000-mc-edac
           - const: loongson,ls3a5000-mc-edac

>
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    edac: mc0@1fe00600 {
> memory-controller@
>
> and drop unused label.
>
>
>> +        compatible = "loongson,ls-mc-edac";
>> +        reg = <0x0 0x1fe00600 0x0 0x50>;
>> +    };
> Best regards,
> Krzysztof
Thanks for your suggestions,

Zhao Qunqin


