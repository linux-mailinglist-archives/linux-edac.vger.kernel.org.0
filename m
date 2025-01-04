Return-Path: <linux-edac+bounces-2782-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20EBEA01194
	for <lists+linux-edac@lfdr.de>; Sat,  4 Jan 2025 02:56:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFDC23A43E9
	for <lists+linux-edac@lfdr.de>; Sat,  4 Jan 2025 01:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B173A3A1BA;
	Sat,  4 Jan 2025 01:56:26 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769B9EC5;
	Sat,  4 Jan 2025 01:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735955786; cv=none; b=T5YpHP1rV2qQ1E56G1MDkJfagCqCFNkR39r9AL03Cv8Ui4Ej5kOXbaMazm0U9tO2gYDv1hDNfutlpPyS0zhBrq/lVznKdpqrU8WIHGOJLo41gI5yTXR3jPuwb/WxvwSQWdA6ZF6JX3nAQMsOCKApkC5nBu6g97ka1Q1YfQGyhCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735955786; c=relaxed/simple;
	bh=fQO4yvx7yvOKnZzz9wTgSRQzq1FxJ5oF2hh6vZ5DQMk=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=HVP6bcxKKbtIWY7SG/dq5284u9IdkrHkqRQ+nmqe+gZ5DyDu/sdxh3dEDKJ7wB0yxtVZ+ZW92nExiiTn4/zm2jfXY7cOEyAvWgFR5FS5iSDBgBAPvpdihE3IW/yIqyBGikpmwpa2a35gWhOsxBfBl647G0XAEjQoLMPlFf3HP6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.164])
	by gateway (Coremail) with SMTP id _____8AxaeFFlXhnXdddAA--.52924S3;
	Sat, 04 Jan 2025 09:56:21 +0800 (CST)
Received: from [10.20.42.164] (unknown [10.20.42.164])
	by front1 (Coremail) with SMTP id qMiowMAx_8VClXhn4RsTAA--.10066S2;
	Sat, 04 Jan 2025 09:56:20 +0800 (CST)
Subject: Re: [PATCH V10 RESEND] EDAC: Add EDAC driver for loongson memory
 controller
To: Borislav Petkov <bp@alien8.de>
Cc: chenhuacai@kernel.org, linux-edac@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@xen0n.name, tony.luck@intel.com,
 james.morse@arm.com, mchehab@kernel.org, rric@kernel.org,
 loongarch@lists.linux.dev, xry111@xry111.site, Markus.Elfring@web.de,
 Jonathan.Cameron@huawei.com, Huacai Chen <chenhuacai@loongson.cn>
References: <20241216013351.15432-1-zhaoqunqin@loongson.cn>
 <20241216115546.GHZ2AVQi9u5lABWboE@fat_crate.local>
 <2d4e5bd0-34dc-d781-3bd6-9eb7be2c1b17@loongson.cn>
 <20250103161942.GGZ3gOHmenp37jlyyd@fat_crate.local>
From: Zhao Qunqin <zhaoqunqin@loongson.cn>
Message-ID: <3194f91f-f20d-714a-20e0-3731df7029c1@loongson.cn>
Date: Sat, 4 Jan 2025 09:55:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250103161942.GGZ3gOHmenp37jlyyd@fat_crate.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:qMiowMAx_8VClXhn4RsTAA--.10066S2
X-CM-SenderInfo: 52kd01pxqtx0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7tr1xZw45KrWDJF45tFWUGFX_yoW8Gw1rpr
	4UZasrtr4vqr4xtw42ga47CF9YywnrJa1agryDJa4UZrnFq34a93y7GFZF93Z2vFn3Xa47
	XayxW39Y9FWYkFgCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWU
	twAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
	k0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l
	4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxV
	WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI
	7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
	1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
	42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j5o7tUUUUU=


在 2025/1/4 上午12:19, Borislav Petkov 写道:
> On Tue, Dec 17, 2024 at 10:25:25AM +0800, Zhao Qunqin wrote:
>> 在 2024/12/16 下午7:55, Borislav Petkov 写道:
>>> On Mon, Dec 16, 2024 at 09:33:51AM +0800, Zhao Qunqin wrote:
>>>> +LOONGSON EDAC DRIVER
>>>> +M:	Zhao Qunqin <zhaoqunqin@loongson.cn>
>>>> +L:	linux-edac@vger.kernel.org
>>>> +S:	Maintained
>>>> +F:	drivers/edac/loongson_edac.c
>>> If you add yourself as a maintainer, I'd expect you to review and/or ack
>>> patches for your driver so that I can pick them up.
>> OK. I can review the patches for this driver.
> Not "can" - I would need you to. I don't have the hardware to test and don't
> have the time to review them.
Let me review the patches for this driver.
>
>>>> +	new = read_ecc(mci);
>>>> +	add = new - pvt->last_ce_count;
>>>> +	pvt->last_ce_count = new;
>>> That last_ce_count is just silly. Kill it.
>> Then  I  can't calculate the error count added since the last check,  cause
>> what record in Loongson's ECC register is  the error count  from reset of
>> the memory controller.
> Can that ECC register be zeroed on each check function run?
That ECC register can not be zeroed.
>
> Because this should work this way: every time you have to issue an error
> message about how many errors were logged, you simply issue the error count
> you've logged this time.
>
> Userspace tools like rasdaemon etc can then aggregate the counts.
>


