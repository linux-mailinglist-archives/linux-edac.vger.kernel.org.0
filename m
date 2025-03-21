Return-Path: <linux-edac+bounces-3393-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF73A6B54B
	for <lists+linux-edac@lfdr.de>; Fri, 21 Mar 2025 08:46:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FFD4188F864
	for <lists+linux-edac@lfdr.de>; Fri, 21 Mar 2025 07:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8BF31E9B2B;
	Fri, 21 Mar 2025 07:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OrnH0a4X"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD971D5CD7;
	Fri, 21 Mar 2025 07:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742543211; cv=none; b=JaV5ty8rkUBIPtqn4X7QshRXoWQgC8LL3On32KtPteW2m3MSyxlccVxSKIWlDiKncMGtHdEQska3UMyWi5Bg230z/wNkePd0cX95DeywlY6Q2rqJg8haNDnH3uad9/55AF5ROI3GL2sZGzE/DdGhXxPAKU171nzOhhVM/HNnay0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742543211; c=relaxed/simple;
	bh=tN3/eqdA02Ff51ubUm4+9RIpIIhvM6qTr2+owkH5aE8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hdpLvAF8oWeixb3xZ95gt7eYm/gG6VAXc+QzXRnynezsO0un4nUh7RjQIL+fzloLIUF21sqxJb5HWhoCH+LtYcNX6pV/1fgH2Ce0g4OsSEHg02BSCmUhqnsCvJFClkm4e4UXopnk0mBMP/fViZ4zRXhqvUszCQVQJOIGyx5oYlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OrnH0a4X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3D7BC4CEE3;
	Fri, 21 Mar 2025 07:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742543211;
	bh=tN3/eqdA02Ff51ubUm4+9RIpIIhvM6qTr2+owkH5aE8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OrnH0a4XjsHrOw4YwVdkAdscm+XQEMp1vsUqwrHCn/6+VfeqEIEnTo1zt0Sl8DG9e
	 aME54juUDUOR1Nth/ZdOEe4BnTg5jJ2SAp9ftdmqrZZYrEyC+o6OB6ei5q4ePZ7fVL
	 YXo9+Z0i3FMZR6JBICyxV0qZQrSBDiDWrEVeKMRGU0ZKGhrFY43TUKwlSJHS9vhtKM
	 d5H32pyXErRnyPij+hWRFWCSKBQ/lNTZfL2ANMdk75Ig0g42HN2HOu5mu8DQxZHnnQ
	 bGbm0I7uGQY2ZxNfbcC/y+4yfqzOsEWfVDXuGjW7sBhcLVhOoKjdPvEwQLXY+SyEby
	 H3P8cwbAsNGlA==
Message-ID: <d37eb60d-fd84-4274-85ac-6ddfd32de3a5@kernel.org>
Date: Fri, 21 Mar 2025 08:46:43 +0100
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] arm64: dts: agilex: Update eccmgr in DTSI to reflect
 hw/yaml
To: "Gerlach, Matthew" <matthew.gerlach@altera.com>,
 Rob Herring <robh@kernel.org>
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, dinguyen@kernel.org,
 bp@alien8.de, tony.luck@intel.com, james.morse@arm.com, mchehab@kernel.org,
 rric@kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-edac@vger.kernel.org
References: <20250320164622.6971-1-matthew.gerlach@altera.com>
 <20250320164622.6971-4-matthew.gerlach@altera.com>
 <20250320193413.GB750632-robh@kernel.org>
 <3b325b3b-df64-4f16-9284-cddfaaa40a21@altera.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <3b325b3b-df64-4f16-9284-cddfaaa40a21@altera.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/03/2025 00:24, Gerlach, Matthew wrote:
> 
> On 3/20/2025 12:34 PM, Rob Herring wrote:
>> On Thu, Mar 20, 2025 at 09:46:21AM -0700, Matthew Gerlach wrote:
>>> Update socfpga_agilex.dtsi to track the actual hardware description
>>> provided in altr,socfpga-s10-ecc-manager.yaml.
>>>
>>> Signed-off-by: Matthew Gerlach <matthew.gerlach@altera.com>
>>> ---
>>>  arch/arm64/boot/dts/intel/socfpga_agilex.dtsi | 18 ++++++------------
>>>  1 file changed, 6 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
>>> index 1235ba5a9865..708cb8e762b6 100644
>>> --- a/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
>>> +++ b/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
>>> @@ -602,8 +602,7 @@ sdr: sdr@f8011100 {
>>>  		};
>>>  
>>>  		eccmgr {
>>> -			compatible = "altr,socfpga-s10-ecc-manager",
>>> -				     "altr,socfpga-a10-ecc-manager";
>>> +			compatible = "altr,socfpga-s10-ecc-manager";
>>
>> You are breaking the ABI here. Before this series, the driver required
>> altr,socfpga-a10-ecc-manager.
> Yes, breaking the ABI required the change in PATCH 2/4, which is 
> suboptimal.


It's still ABI break for no good reason.

Best regards,
Krzysztof

