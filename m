Return-Path: <linux-edac+bounces-5247-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A477C1886D
	for <lists+linux-edac@lfdr.de>; Wed, 29 Oct 2025 07:53:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 95DB94E5156
	for <lists+linux-edac@lfdr.de>; Wed, 29 Oct 2025 06:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7443081AC;
	Wed, 29 Oct 2025 06:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ic5vE5HF"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317B22F1FC3;
	Wed, 29 Oct 2025 06:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761720724; cv=none; b=Yp/z48qeeNp7PYTf/1p9qZT6gBHtuDTNNThBtrW6y2b0S0b/EQkw+EdZ2KS4ds2Ckr8AbyZt6BPDWBe9uIK6KeCwQ1iSaCdGDQpz9n7gl6xebkARB/xlHPyZ+syS3HP8SvA5y0sEvSuyygo0jtlsNTcqvdsACAdsqw4PE+jfPcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761720724; c=relaxed/simple;
	bh=l6HE50NYzVpvk6w6p49su6B033S2ak7A3dICFhMDKQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F38swqKrShUcZKYRR/OzIItkY4zQ5cMUfEqmmVyedhtji/M8Exxm9sTNZupg774BPu5UN2IXwh5eADiJsZqXuQd4k3rIvnEfDbtlPbxgjUV9xSQk4GJJYFAHvJBCPMy9xvizMjHuzGKEsWLDZL2UnR2YGoVZ/VU7aCNdsMJz57A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ic5vE5HF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98908C4CEF7;
	Wed, 29 Oct 2025 06:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761720723;
	bh=l6HE50NYzVpvk6w6p49su6B033S2ak7A3dICFhMDKQ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ic5vE5HFrPGe0CKBN7ZaxMLWP5UhoUw1pOWAwgya0Mh6bbeuCQ76vI+5Oj7/7BN4s
	 qAaSQRMcQ9Mog2cjcaoFA8amz6CwDqSh6O05CPa7j+MkoKVO1Tv4Pg9VmZELt7pn4h
	 WqsE8K13hVyr9i2zMSNkJdztWouXozspu5GogDajjonsJ2StxoqiEQXqhnEse8DIrb
	 cQ54k+SgKXdPPcChGWTnZfXsGeZ52Iy85ObkyMO64GErvXSMXn9l6Z/5iwct5zn4my
	 B6qqOl1QJ3+A+rM1CFFfcKimsZzx8r/HAS+bHAzmBqa5JjweTAxveKY9zgFlTvfAEM
	 DcrpZe+OHvq9g==
Date: Wed, 29 Oct 2025 07:52:00 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: niravkumarlaxmidas.rabara@altera.com
Cc: dinguyen@kernel.org, matthew.gerlach@altera.com, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, bp@alien8.de, tony.luck@intel.com, 
	linux-edac@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] EDAC: altera: Add ECC support for SDM QSPI on Agilex5
Message-ID: <20251029-onyx-frog-of-protection-8b4eaa@kuoka>
References: <20251028092232.773991-1-niravkumarlaxmidas.rabara@altera.com>
 <20251028092232.773991-7-niravkumarlaxmidas.rabara@altera.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251028092232.773991-7-niravkumarlaxmidas.rabara@altera.com>

On Tue, Oct 28, 2025 at 05:22:32PM +0800, niravkumarlaxmidas.rabara@altera.com wrote:
> From: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>
> 
> On Agilex5 SoCFPGA, the Secure Device Manager(SDM) manages ECC protection
> for the QSPI. Since SDM operates in secure mode, all register accesses
> must go through ARM Trusted Firmware (ATF) using Secure Monitor Calls
> (SMC).
> This driver uses the SMC interface to initialize ECC, handle correctable
> and uncorrectable error interrupts, and support error injection using
> debugfs.
> 
> Signed-off-by: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>


How in one patchset you cannot get same subject prefix right?

Best regards,
Krzysztof


