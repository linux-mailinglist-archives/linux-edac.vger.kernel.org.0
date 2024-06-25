Return-Path: <linux-edac+bounces-1363-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ACD3915F10
	for <lists+linux-edac@lfdr.de>; Tue, 25 Jun 2024 08:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B9AB1C21B17
	for <lists+linux-edac@lfdr.de>; Tue, 25 Jun 2024 06:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54803146583;
	Tue, 25 Jun 2024 06:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZGtwc8Oe";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="F9tjITLi"
X-Original-To: linux-edac@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C9314600C;
	Tue, 25 Jun 2024 06:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719298217; cv=none; b=umTtnJF6Z4RS2+YbV5hV7f9en2PIRpKhntDaHs7S3MVfRsivfuDFadkyZsOsuU6l7jlzVde8U+4yKKTngvE9gaEe7rRUXDRSu7kk7lMiFqqa98mS7eN4PdPgEdr+2PMgJZEyUFTiKJwkxk2OexoE9Oj+6K00mzfUzmy1jnIUzH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719298217; c=relaxed/simple;
	bh=dyI5FDukg7XrQ34wAby0hl4PFiwXKNR20QxarcbcBXI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PNVCJuqZ8g2KM9+6Sb47os1otkCUH8lQpswnY3Gpksn/TV/+RauxjMobThrDAGrkLFZFYg2P4IdkA2RqNzD9aanvtEZiACRwhHOgwq0zjmZW9SmrN+wBuQOtgiJnHRizWKKHjJoGv1Wqg6EKHm/cTb+0SD+Dx11tZA+P4GG7pOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZGtwc8Oe; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=F9tjITLi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719298213;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s8BGegiK6PP/KFU7MXAcEdJ4lJqNqTKanruwT8h5Mww=;
	b=ZGtwc8Oel6h9OjhRCnBJLNr6MdIj3CvTThe8J473hxfAyCLj8oz2J49XLcAvBPEL0KDpDz
	tz69UjlefGgbWLwUaibEARvM4apn38KRiIFWk7FMjXZD9m1XOwKEtgX0OD4R5t0mSu34BL
	4Dvay1VrmuJn8eId+cbwcSK7b7g3AVrPlApR4fUXh2k/H93MW0Cs/VsZEjEyqwd4K3kOJn
	V3lViw33esU35uM0vb08FvSsgAjPgX5vFF4PidKi/DjiEKM8Eqajv2peM+ez8HzSXWBILC
	ux4yubrxKtOZYlwU6Ropp+Gx5ay6XcG+LGdyb/TzAmEHvN99aQqJeCN/ndUm+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719298213;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s8BGegiK6PP/KFU7MXAcEdJ4lJqNqTKanruwT8h5Mww=;
	b=F9tjITLi5+7rSsOoINefAhq7dzL9mFTIPr0B96Y6GXQA7TvmtgDZvbX4rLKll2ftKeebWR
	xO5PRpfzpEZtvZAg==
To: Yazen Ghannam <yazen.ghannam@amd.com>, linux-edac@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, tony.luck@intel.com, x86@kernel.org,
 avadhut.naik@amd.com, john.allen@amd.com, Yazen Ghannam
 <yazen.ghannam@amd.com>
Subject: Re: [PATCH v2 1/5] x86/topology: Export helper to get CPU number
 from APIC ID
In-Reply-To: <20240624212008.663832-2-yazen.ghannam@amd.com>
References: <20240624212008.663832-1-yazen.ghannam@amd.com>
 <20240624212008.663832-2-yazen.ghannam@amd.com>
Date: Tue, 25 Jun 2024 08:50:13 +0200
Message-ID: <87ed8l7byy.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Jun 24 2024 at 16:20, Yazen Ghannam wrote:

> The need to look up a CPU number from an APIC ID is done in at least one
> other place outside of APIC/topology code:
> apei_smca_report_x86_error().

The need .... is done?

>  #ifdef CONFIG_X86_LOCAL_APIC
>  int topology_get_logical_id(u32 apicid, enum x86_topology_domains at_level);
> +int topology_get_cpunr(u32 apic_id);
>  #else
>  static inline int topology_get_logical_id(u32 apicid, enum x86_topology_domains at_level)
>  {
>  	return 0;
>  }
> +
> +static inline int topology_get_cpunr(u32 apic_id)
> +{
> +	return -ENODEV;

Why ENODEV and not 0?

> +}
>  #endif

Thanks,

        tglx

