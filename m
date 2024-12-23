Return-Path: <linux-edac+bounces-2749-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB7D9FAF44
	for <lists+linux-edac@lfdr.de>; Mon, 23 Dec 2024 15:04:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BC231660CB
	for <lists+linux-edac@lfdr.de>; Mon, 23 Dec 2024 14:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8829C1A8F83;
	Mon, 23 Dec 2024 14:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gQCVXPsT"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5829D1C36;
	Mon, 23 Dec 2024 14:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734962553; cv=none; b=JO6je0sWZlygj17YYNx0pxj7pKJW4UQeYLmw8E9F6vUi8LD10TU0AHOpRdvIK0EYQs+h2A9Hi4GB7NOKFnDM0Ql3PKSau52jPrIBgERNgcf6Ko0azh3O4SREShSyZn0cU+Uqgc3NMkYbu+1Hs5naBpSwoi9XSH0pxrLtnPK/dEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734962553; c=relaxed/simple;
	bh=2bc39lGmRDyRTMKFrvekKMPvbpMIxvBQYnK4Uqobs8A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I91Pm+TCBO6gDjS9fB1UlrL3a26HAYWemDN814FqKbXV7HlaCdxXtPnoL5mhUy9xDDqE+Qenc471iKsCZjE7cAxXzKMtEh+FAVnxeEXc1POnh7CfdujytJHSlq3qk9ReWcRJPXEFR9wwZbg43IxZl8jZwncQBPZMfpe0cAp3OGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gQCVXPsT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6591FC4CED6;
	Mon, 23 Dec 2024 14:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734962552;
	bh=2bc39lGmRDyRTMKFrvekKMPvbpMIxvBQYnK4Uqobs8A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gQCVXPsTumLIzKmb/KPHU3TPC3sKDjBHYxNBMe4CHhfDyHyvgrdtWRPOSAhEn3vHy
	 Wh1QNijhPOogA4+OiwxOgVJNqZChKPHmAkWaiKcvH+1Z3V6uVWmIp7XZV22FBFWUBg
	 JiAPkUW+7SWe/SpRCWcXp2obIYGCXUpJB6tLflanj4Mvi9Cx8xO95+snzcEnQuxZ57
	 eblBZTITYPJZavCf5w6l4jxiYVP5ps36vo6izJNzLQXiOHuAl59fbGK0iVOKorUaih
	 ceaWZc5D+srBJsB4pX342hvIZ3pHqC8A6k4wuROhnQoEkbdQeBh78fi9vFfN8lC3Ge
	 mFa7gsqvGy78g==
Message-ID: <c4b58b22-804b-4175-abb8-ff8929c5821d@kernel.org>
Date: Mon, 23 Dec 2024 15:02:26 +0100
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: memory-controllers: Add support for
 Versal NET EDAC
To: Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>
Cc: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-edac@vger.kernel.org, git@amd.com, krzk@kernel.or, robh@kernel.org,
 conor+dt@kernel.org, bp@alien8.de, tony.luck@intel.com, james.morse@arm.com,
 mchehab@kernel.org, rric@kernel.org
References: <20241122100625.24571-1-shubhrajyoti.datta@amd.com>
 <20241122100625.24571-2-shubhrajyoti.datta@amd.com>
 <uw5yvotdr4u5uau7bqjj2qdmkf5ay2bm7km3zhqunbixzljlw6@wi6cujvdhesk>
 <CAKfKVtEREOLxK=SF5F-3MkpxyS+HcSTOH-pML2b4x2pCV13XMA@mail.gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <CAKfKVtEREOLxK=SF5F-3MkpxyS+HcSTOH-pML2b4x2pCV13XMA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 23/12/2024 10:58, Shubhrajyoti Datta wrote:
> Hi Krzysztof,
> 
> On Sat, Nov 23, 2024 at 10:14 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>
>> On Fri, Nov 22, 2024 at 03:36:23PM +0530, Shubhrajyoti Datta wrote:
>>> Add device tree bindings for AMD Versal NET EDAC for DDR controller.
>>>
>>> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
>>> ---
>>>
>>
> ..
>>> +
>>> +  amd,dwidth:
>>> +    description:
>>> +      DDR memory controller device width.
>>
>> Use existing properties.
> I am not finding any existing properties could you help me with some pointers.

Really? `git grep width` gives plenty of choices, depending on the meaning.

I don't know what this property is about - your description is not
helping. Either obvious or not correct, because memory controller cannot
have a width. Like width in cm? inches?

> 
>>
>>
>>> +    enum: [16, 32]
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>> +
>>> +  amd,num-chans:
>>> +    description:
>>> +      Number of channels.
>>
>> Use existing properties, e.g. some of the DDR schemas describing memory.
>> Look how other bindings describe actual chips.
> 
> could you share any example. My search didnt return anything

I don't believe you tried to search then... There are like 5 bindings
describing some parts of memory bus to choose from. There are dedicated
bindings for DDR memory - it's all there. Look how other bindings
reference JEDEC DDR.


Best regards,
Krzysztof

