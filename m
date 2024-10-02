Return-Path: <linux-edac+bounces-1955-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0942698D1BE
	for <lists+linux-edac@lfdr.de>; Wed,  2 Oct 2024 12:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CFD01C20D02
	for <lists+linux-edac@lfdr.de>; Wed,  2 Oct 2024 10:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA7A1E7676;
	Wed,  2 Oct 2024 10:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DDwH/7vC"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6941E766B;
	Wed,  2 Oct 2024 10:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727866364; cv=none; b=cw8tCdKJ+g8mkYd2HDZaVz6SQNb/76vHSRKjzA2YMcJlRTqbaBk9hKyNl7VPBRHA1xpaZ+Go9iAWriDbUoePvyvVHStDce413zUSDMaq46DGVLQjdCSl+I2l0XHykHS3spv5VArzJ5n0eFJ5exuw19NPBxCqWmrqdCn+b1JIYzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727866364; c=relaxed/simple;
	bh=p6wM7yoi7GfKuoD5YhbWY+B9mXoXSBTQn4zINgkEvdU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=KRQyXmhTnjJRsth+c7W6YynLaT023eipJPh+g2qB/x1/cdc9Tuy612fVMrNRY6oJajBUNplxc5QO43DaAwmva+qSKsIJd7Q/vlIaxxjwsbGMMwfpg5aKoc6i68TJtS/2ZWyfE1jZddRh84mgTHcRSZyQvmyp4uxpDkXQ0pLdHf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DDwH/7vC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23ADAC4CEC5;
	Wed,  2 Oct 2024 10:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727866364;
	bh=p6wM7yoi7GfKuoD5YhbWY+B9mXoXSBTQn4zINgkEvdU=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=DDwH/7vCkNAcQ87Yd4sFzTzAEfNG1R6O3wGlHGV97iOMu18JfmDsu2Z/1zg29zcZR
	 QmWKZlXp1zJc18aEw5xT5RFVA1jqseh+70E+GwjXppTJ46/EyyK3dlWh63SpoSAlFe
	 hbiwJFBCrFlD4sG+GNrUGCNVzCRZhsOcpnCCpk1nspJakft8jtXyk9/V7C33Dq67ik
	 fD00lCtEZ7U4j2PD2rr/8tbIuV+yEW2VEC6zwhiAL0DzliLq9ty00P3ndst4agd9TB
	 qK1IMULmJFqTO8EjaeYSXDSkH/+WcPfUTnPTCG7twPxmqVYvV2er6SokHPt60qWqIq
	 kLWnbCXnSTdzg==
Message-ID: <a624690e-12c1-44f2-a867-5a9959091c91@kernel.org>
Date: Wed, 2 Oct 2024 12:52:35 +0200
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] EDAC: fsl-ddr, add imx9 support
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Borislav Petkov <bp@alien8.de>, Frank Li <Frank.li@nxp.com>
Cc: York Sun <york.sun@nxp.com>, Tony Luck <tony.luck@intel.com>,
 James Morse <james.morse@arm.com>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Robert Richter <rric@kernel.org>,
 Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, linux-edac@vger.kernel.org,
 linux-kernel@vger.kernel.org, Borislav Petkov <bp@suse.de>,
 devicetree@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, Priyanka Singh
 <priyanka.singh@nxp.com>, Sherry Sun <sherry.sun@nxp.com>,
 Li Yang <leoyang.li@nxp.com>, Ye Li <ye.li@nxp.com>,
 Peng Fan <peng.fan@nxp.com>
References: <20240709-imx95_edac-v1-0-3e9c146c1b01@nxp.com>
 <ZvsNJrxF6TpUC6ws@lizhi-Precision-Tower-5810>
 <20241002090834.GAZv0Nkp5YKcy86UmZ@fat_crate.local>
 <c90354e6-2e95-4f96-bbc9-508edb293183@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <c90354e6-2e95-4f96-bbc9-508edb293183@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/10/2024 12:48, Krzysztof Kozlowski wrote:
> On 02/10/2024 11:08, Borislav Petkov wrote:
>> On Mon, Sep 30, 2024 at 04:42:14PM -0400, Frank Li wrote:
>>> On Tue, Jul 09, 2024 at 04:23:01PM -0400, Frank Li wrote:
>>>> Add imx9 support for fsl-ddr.
>>>>
>>>> Patch 1-2 is prepare patch, no function chagne
>>>> Patch 3 is small fix for bit shift
>>>> Patch 4 is dt binding patch.
>>>> Patch 5 is driver change to support imx9
>>>> Patch 6 is imx93 dts change
>>>>
>>>> Signed-off-by: Frank Li <Frank.Li@nxp.com>
>>>> ---
>>>
>>> Borislav Petkov:
>>>
>>> 	More than 2 monthes. I ping at Thu, 29 Aug
>>> https://lore.kernel.org/imx/ZtDwG2xFGaUssJVN@lizhi-Precision-Tower-5810/
>>>
>>> 	Any reason why not pick these EDAC patches?
>>
>> $ ./scripts/get_maintainer.pl -f  drivers/edac/fsl_ddr_edac.c
>> York Sun <york.sun@nxp.com> (maintainer:EDAC-FSL_DDR)
>> Borislav Petkov <bp@alien8.de> (supporter:EDAC-CORE)
>> Tony Luck <tony.luck@intel.com> (supporter:EDAC-CORE)
>> James Morse <james.morse@arm.com> (reviewer:EDAC-CORE)
>> Mauro Carvalho Chehab <mchehab@kernel.org> (reviewer:EDAC-CORE)
>> Robert Richter <rric@kernel.org> (reviewer:EDAC-CORE)
>> linux-edac@vger.kernel.org (open list:EDAC-FSL_DDR)
>> linux-kernel@vger.kernel.org (open list)
>>
>> This driver has a maintainer. Is he going to review it or can I remove
>> him from MAINTAINERS?
> 
> Let's drop York, it's a stale maintainer entry.

I sent a patch now for this.

Best regards,
Krzysztof


