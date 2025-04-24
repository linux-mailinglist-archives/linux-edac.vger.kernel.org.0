Return-Path: <linux-edac+bounces-3713-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A639A9BAFF
	for <lists+linux-edac@lfdr.de>; Fri, 25 Apr 2025 00:58:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB5789A2586
	for <lists+linux-edac@lfdr.de>; Thu, 24 Apr 2025 22:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BAFE221712;
	Thu, 24 Apr 2025 22:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KB/Seoi3"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0159D19DF7D;
	Thu, 24 Apr 2025 22:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745535521; cv=none; b=I13T5ucPXgqcquLB2tHNLyRccbX3UBtuiyb/lV72rO+xXhNaGaE+uV7aJWnQBEMa/i556BaFgYUevZKPT5HxUUKTXjRshQ3j/TezxzVQVf/Q21rasgOvov4yobRL5we1KhHvbyoVMlqM40obSgIlTXB9RULHYm9iV/uUKv+0Wy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745535521; c=relaxed/simple;
	bh=ACYjDi6CjEq4j64VIpcmIebNQmYUwCOsuVNTD3r9n0c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lsCjVmPPwPWtN+TrAHP1rWwtGXk7osKR4lYFX62LNlsEfG8F9NK14HeIkXTMQ6U/v8Y8mlqmL4UdesBFwWkqRs7jYhqZRuH1Y3eB3kZUqGsRru1MgkxdDkKrOiHjFtEyepcC2mRP182vr4CLN02XIUL35JLTalBpPfafMcwJWXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KB/Seoi3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C9CFC4CEE3;
	Thu, 24 Apr 2025 22:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745535520;
	bh=ACYjDi6CjEq4j64VIpcmIebNQmYUwCOsuVNTD3r9n0c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KB/Seoi3vbdDi3cFSxoKq/l2fqizN/rCTQ+No8ys6oQrpHwnCBSuOMCFabvu5AmI4
	 /vtl0g53m8E+Y9Rf4fuoF0roVhWRp9/0Eqe6rN8BbdlQ7Dj65nGmcTQnG5P6RU0mpw
	 4uSWLKLXhW7BvJ+/5Rc6XeZWxKJJs1VOiiEuT2ailAsYw80VeqxpIvzCxxYa6oKzGK
	 yc0zRfZdn6ICNM7Mhd8Krhn7cO8acIq9jz3XzgdjelcXHLqnTyfdbHWOWSODf8DUiS
	 HITkNgdofuhjKeMljOeN1U+Hwl1iuKRyg0daOyOlmEpbrXwamrwkKNID69jJ/rrIs1
	 rPqU4IYtfZQBA==
Message-ID: <bedaa79b-721b-488f-b69f-f1bc5b6d166d@kernel.org>
Date: Thu, 24 Apr 2025 17:58:38 -0500
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] EDAC/altera: Set DDR and SDMMC interrupt mask
 before registration
To: Matthew Gerlach <matthew.gerlach@altera.com>, bp@alien8.de,
 tony.luck@intel.com, james.morse@arm.com, mchehab@kernel.org,
 rric@kernel.org, tthayer@opensource.altera.com, linux-edac@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Niravkumar L Rabara <niravkumar.l.rabara@altera.com>, stable@kernel.org
References: <20250421161447.41886-1-matthew.gerlach@altera.com>
 <20250421161447.41886-3-matthew.gerlach@altera.com>
Content-Language: en-US
From: Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20250421161447.41886-3-matthew.gerlach@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/21/25 11:14, Matthew Gerlach wrote:
> From: Niravkumar L Rabara <niravkumar.l.rabara@altera.com>
> 
> Mask DDR and SDMMC in probe function to avoid spurious irq before
> registration.  Removed invalid register write to system manager.
> 
> Fixes: 1166fde93d5b1 ("EDAC, altera: Add Arria10 ECC memory init functions")

Please just use 12-digits

Dinh


