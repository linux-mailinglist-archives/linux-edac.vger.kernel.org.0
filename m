Return-Path: <linux-edac+bounces-1811-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD90B96B590
	for <lists+linux-edac@lfdr.de>; Wed,  4 Sep 2024 10:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CC73B2AEB6
	for <lists+linux-edac@lfdr.de>; Wed,  4 Sep 2024 08:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 443521CC8B9;
	Wed,  4 Sep 2024 08:52:32 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46CD81CC8AD;
	Wed,  4 Sep 2024 08:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725439952; cv=none; b=g8xO0Z5hW4TZQ8F00kkqCcEj40hf6lwzKvi8jyGgyXEF0Ps5Cgyq38uKSaSWjWD9fd2cf+kBl3lVRJO3kwiEQ4h7O5Md936kLXRz+z8uGdif2YXYrlE54ld3Ge59PUcntyLo7LmzdtdtTSSdb07m4r8vhVl1AxBnqBbXdRl9dgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725439952; c=relaxed/simple;
	bh=IvkSCBt+3+2VjlsISB6I1MkJWO67OCf7/ELVtxu1nT8=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=kqVAJbQcs2cDzy4FGPOi91ue6Nan7z8LAQdPMKl58VFaNKMQimTaPgy6UUzK2XoD5nbVdokyv4hONGELP+xhrBDWCUfR5+TZsj8KNY/iqpZMXSsYuHkfDIEAfn05SSK0FtIPOZhXqmc0mdyNXCTvS9U/5+hZ6cY0O7f/HzPlSco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.164])
	by gateway (Coremail) with SMTP id _____8BxmprFH9hmkRYqAA--.44894S3;
	Wed, 04 Sep 2024 16:52:21 +0800 (CST)
Received: from [10.20.42.164] (unknown [10.20.42.164])
	by front2 (Coremail) with SMTP id qciowMCxH8bDH9hmi64FAA--.16454S2;
	Wed, 04 Sep 2024 16:52:20 +0800 (CST)
Subject: Re: [PATCH V3 1/2] dt-bindings: EDAC for ls3a5000 memory controller
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 chenhuacai@kernel.org, linux-edac@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@xen0n.name,
 bp@alien8.de, tony.luck@intel.com, james.morse@arm.com, mchehab@kernel.org,
 rric@kernel.org, loongarch@lists.linux.dev
References: <20240903114714.11428-1-zhaoqunqin@loongson.cn>
 <20240903114714.11428-2-zhaoqunqin@loongson.cn>
 <c901ff6b-2e4d-4dd1-82da-e2e3d5db7988@kernel.org>
 <32aded46-86ce-59cf-e8b4-2621c0dd9ebe@loongson.cn>
 <c1508929-2e44-497d-b54a-285a3e74ba2d@kernel.org>
From: Zhao Qunqin <zhaoqunqin@loongson.cn>
Message-ID: <3beb1cf3-c033-bdec-7d38-f43889d4dc2c@loongson.cn>
Date: Wed, 4 Sep 2024 16:51:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <c1508929-2e44-497d-b54a-285a3e74ba2d@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:qciowMCxH8bDH9hmi64FAA--.16454S2
X-CM-SenderInfo: 52kd01pxqtx0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj9xXoW7Jw4Uuw4DCF45XFW5ZFW7WrX_yoWDJwb_Kw
	4YywnruwnFya4kGFsxJF4xJryvqw4UtrWUur1kXr1Fqw1FqFZrZr4rK34fZw15JFW3WFnr
	CFZrWFWkCr9xuosvyTuYvTs0mTUanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbqkYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_JrI_Jryl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y
	6r17McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr4
	1lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxG
	rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUXVWUAwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jruc_UUU
	UU=


在 2024/9/4 下午1:51, Krzysztof Kozlowski 写道:
> On 04/09/2024 03:15, Zhao Qunqin wrote:
>> 在 2024/9/3 下午8:29, Krzysztof Kozlowski 写道:
>>> On 03/09/2024 13:47, Zhao Qunqin wrote:
>>>> add device tree bindings for ls3a5000 EDAC driver.
>>>>
>>>> Signed-off-by: Zhao Qunqin <zhaoqunqin@loongson.cn>
>>> So no improvements? No changes? Why do you send the same?
>> I'm sorry,  I thought if you hadn't raised any issues with the previous
>> version of dt binding, I wouldn't need to make any changes.
>>
>> For this version of the patch, I only changed the driver.
> So what changed? Where is the changelog? Where is the tag? Did you get one?
>
> Did you read submitting patches document?

My apologies! I must have missed a part of the content in the document, 
please forgive me for wasting your time.

Will add tag and changelog in  patch v4.

Thank you very much for taking the time to review.


Best regards,

Zhao Qunqin.

>
> Best regards,
> Krzysztof


