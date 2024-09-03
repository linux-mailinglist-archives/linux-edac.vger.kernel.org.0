Return-Path: <linux-edac+bounces-1787-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF84969BDC
	for <lists+linux-edac@lfdr.de>; Tue,  3 Sep 2024 13:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5F521F24471
	for <lists+linux-edac@lfdr.de>; Tue,  3 Sep 2024 11:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2FD21A42B3;
	Tue,  3 Sep 2024 11:32:00 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59E019C567;
	Tue,  3 Sep 2024 11:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725363120; cv=none; b=Y5NUGkyypd/kmFGLOhfIB1jzlcKLIE/yXoBxwb966xU/eIebBpt3mzyWB5mZpdMM6Axpvbu1FM6nONnVMkPbWm9YKSvQMxJh6qe2YRBoYwW13WwH6NNOGee6dsy1hCB0hXiMh2WyjrrmYzb7Q/UGH5DLqNvdJ4m6ZHOmYyK2lQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725363120; c=relaxed/simple;
	bh=mC+IP5hNoHMXmxxSx6m4Q3kFzM+A1vCOB9E0ebmtcEo=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Wni4VJB026bQQ+4u7YOsSbvgjOIohXHsvRytyWQz0+olxlt3IFHh5O9ux81jEnO7/pXVNhDFrIq4cBVderk7LfzzBxdZyvtivKzs2WhkvQx9X5l0T1a5NH9BKvNpHR09P9DmATX6ghHhm8xOJYttKpW2t1s2RmFaEsr4vRRTFoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.164])
	by gateway (Coremail) with SMTP id _____8Bxa+qr89ZmwSEpAA--.14498S3;
	Tue, 03 Sep 2024 19:31:55 +0800 (CST)
Received: from [10.20.42.164] (unknown [10.20.42.164])
	by front2 (Coremail) with SMTP id qciowMAxfcWp89Zm5dIEAA--.13029S2;
	Tue, 03 Sep 2024 19:31:53 +0800 (CST)
Subject: Re: [PATCH v2 2/2] Loongarch: EDAC driver for loongson memory
 controller
To: Krzysztof Kozlowski <krzk@kernel.org>, Xi Ruoyao <xry111@xry111.site>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 chenhuacai@kernel.org, linux-edac@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@xen0n.name,
 bp@alien8.de, tony.luck@intel.com, james.morse@arm.com, mchehab@kernel.org,
 rric@kernel.org, loongarch@lists.linux.dev
References: <20240903015354.9443-1-zhaoqunqin@loongson.cn>
 <20240903015354.9443-3-zhaoqunqin@loongson.cn>
 <jkdyayyjrzuhhfaueiessntfdof2m55xjxedkl3zp2jalf4sii@3fo65j64c6rv>
 <549969b7-26c4-a203-b5a0-2e89ab7e7d79@loongson.cn>
 <979d67cc-cbd2-408c-a8ca-a063030bcec2@kernel.org>
 <5c0003ae887f2f80f7852498e1c1a3ff2c07129e.camel@xry111.site>
 <0f9e9184-740f-4a47-b653-a4b1d1c1239a@kernel.org>
From: Zhao Qunqin <zhaoqunqin@loongson.cn>
Message-ID: <f534cc40-56d5-2ac8-4db6-aaaa32b07e2f@loongson.cn>
Date: Tue, 3 Sep 2024 19:31:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <0f9e9184-740f-4a47-b653-a4b1d1c1239a@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:qciowMAxfcWp89Zm5dIEAA--.13029S2
X-CM-SenderInfo: 52kd01pxqtx0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj9xXoWrZw1UXF1kur4xGr17Ww4UGFX_yoW3ArXEkr
	Wjv348uas7uF9xJFWDtFn5uF93t3yUZryay3409rZ0g3sxJrZ8ua95ur15Wwn0qFWjgFn5
	GF42qayfC3y5WosvyTuYvTs0mTUanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbqAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_JrI_Jryl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y
	6r17McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr4
	1lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxG
	rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUXVWUAwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxU4FApUU
	UUU


在 2024/9/3 下午7:29, Krzysztof Kozlowski 写道:
> On 03/09/2024 10:30, Xi Ruoyao wrote:
>> On Tue, 2024-09-03 at 09:58 +0200, Krzysztof Kozlowski wrote:
>>>>>> +	select EDAC_SUPPORT
>>>>> I think you got here comment before. How did you address it?
>>>> I just randomly found a spot, and I will put it at the end(next version
>>>> patch).
>>> No, the comment was different. You must not select user-visible symbols.
>> EDAC_SUPPORT isn't user-visible.  EDAC is and it has been removed.
> Ah, ok, I missed that. Shouldn't this be separate patch with its own
> rationale? Or before this driver there was no EDAC support for Loongson
> at all?

Before this driver there was no EDAC support for Loongson
at all.

Best regards,
Zhao Qunqin.

> Best regards,
> Krzysztof


