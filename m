Return-Path: <linux-edac+bounces-5538-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07252C8AB6A
	for <lists+linux-edac@lfdr.de>; Wed, 26 Nov 2025 16:42:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA1033AFA67
	for <lists+linux-edac@lfdr.de>; Wed, 26 Nov 2025 15:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B8233468C;
	Wed, 26 Nov 2025 15:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Tp0g8t2Y"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4922225408;
	Wed, 26 Nov 2025 15:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764171751; cv=none; b=DGrPQ1SPMzpUQHXDGYYk3kZDwaVi3dmINo518bMEq+FHav+s0XReI1dqpJQpX4ntClCMgL85JgJnT0MrsQAaIUqI5i2rqTN3PePUlWDU3PlYHJd6oMyFLt4Zf20QUijihO1Li/bDltN5wKkFduQ8pRETJ2R+/BC7laBmBcYNAJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764171751; c=relaxed/simple;
	bh=E7XcO8XldQNFTnS+OgpJFv7vRm4iBQLHonK1m3VqKMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ekolUzvtaRuoxyx3ijq/s4CUWylVK2qq6q3jzPynXMDVuWCfNRPgorh/LQUlwS3N5kCpBt6m/Xn5qZkwLCMnGOwEqbtgpV6hKBIRvEAAohaeZpgb18D72Aq/3znjqOxW7gTuz4Ymai3ThdcTeTmfqbWTVPc0T+VANKXiXVw8MAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Tp0g8t2Y; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8AE6E40E0218;
	Wed, 26 Nov 2025 15:42:26 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ijxHRrQuaD7J; Wed, 26 Nov 2025 15:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1764171742; bh=PcYhz2q6NSCsUoknTKwoED8MYX12e4GmDI4oTmB8JvU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tp0g8t2Y0QQ8wU0Ta5aQj3ToY0yyXWt6JVeaa/fwpXwqDBkOW7JaerJ4Y/36OuxKJ
	 p/FhR//zUvGDBpDVvn5GKTMwE5m1qgDAmffc6gPxgw24d01ZE83MRe/wvbKv6vIwki
	 PsoiGnwYADgZfSjSVJAxDVk0FlcvOwFVd+kasTVPw9hnQGmcN9BcESqj9rYyenV71s
	 VPB6ig72hvuevGdtu/Qug8O6jILQanxLV2AyUiRWpiQgSsmPMlDryPIvZ7XcRf4ZVq
	 7m0fnzAH/gRNqZ8e+WBxfP42YrzJ9idnu1pAVVNM3JpU88pv0+LhMiLz9QISyNDe3F
	 pyP37bescK4lxE02fLHNkBKVCE6LXAUNKsR6uGGJQu73Jetoux17V5UptJkDu0KIFv
	 RJnYDTL181RjUkISt957RTFp1IHLNRlx8xzsDFdbllOjjT8CIgF0Cd8Ol9SKqYeeYK
	 TXTdl1M5jqWagAvZ+MTOENTZdt5obWIDlKO9/XxpR8UndlMWB61NaMDtyDZqHaDYnd
	 QNDewyzlUwa6TDVoIPKPhNPkvRuRrqGVJaVL5yOR2KkLMUCWEfCYlpvV0uG8ds6Rto
	 TrwAhW2JW4G1EsDnDXCSKF5DqdNFYEOoxS309R96rMr/tsUqsqIEBBNisu61LyRz4q
	 2ILuZMw6gVkFqYP8dc3E6tso=
Received: from zn.tnic (p57969402.dip0.t-ipconnect.de [87.150.148.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 677A640E00DA;
	Wed, 26 Nov 2025 15:42:07 +0000 (UTC)
Date: Wed, 26 Nov 2025 16:42:00 +0100
From: Borislav Petkov <bp@alien8.de>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>, Ira Weiny <ira.weiny@intel.com>,
	Jason Tian <jason@os.amperecomputing.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Len Brown <lenb@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
	Tony Luck <tony.luck@intel.com>, linux-acpi@vger.kernel.org,
	linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] apei/ghes: don't go past allocated memory
Message-ID: <20251126154200.GEaScfyLUdgVvu1FVy@fat_crate.local>
References: <cover.1764169337.git.mchehab+huawei@kernel.org>
 <3f6764ddbc0b596a43a73616d972c2ba0060d1b1.1764169337.git.mchehab+huawei@kernel.org>
 <20251126151325.GCaScZFXvm-7PYy0Dh@fat_crate.local>
 <mn45f66kdydxqugsdzln2j7sqs6g5o2iwo4hd6l3klbiavidon@53ergacbysko>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <mn45f66kdydxqugsdzln2j7sqs6g5o2iwo4hd6l3klbiavidon@53ergacbysko>

On Wed, Nov 26, 2025 at 04:26:56PM +0100, Mauro Carvalho Chehab wrote:
> The dump is a summary. I can expand them if you prefer:

I said "summarize" not expand.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

