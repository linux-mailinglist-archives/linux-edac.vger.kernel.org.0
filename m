Return-Path: <linux-edac+bounces-1746-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D69E99647BB
	for <lists+linux-edac@lfdr.de>; Thu, 29 Aug 2024 16:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 688DC286799
	for <lists+linux-edac@lfdr.de>; Thu, 29 Aug 2024 14:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0FE71AD9DE;
	Thu, 29 Aug 2024 14:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="jhyYiY7A"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9601C192B71;
	Thu, 29 Aug 2024 14:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724940880; cv=none; b=f1Y8qugytK6HsHbvHotbQOGIKIT+10EypxH3zYSTZchIy0yN790T2HDWG2GafKCCciJ04hIBwJB1y4tPH32+YEtZhpee72Uhce0lOyHHxKBI0CtS1IVFt3iho6krgTTV2Arlu2qwVJdRN733rU5i029j0V6FANs3cHoGODcoHnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724940880; c=relaxed/simple;
	bh=HJNd/dS8m5R+pV/28hX/PbxnytWLOjhdv6lhnypUDIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y+7hEfH4MBMwWhPrJAOWlgisdyktAIyJP4iKR0BYYdOB7lbsS7I1J9V8Fwc7UmIORTIUh581MlktM2bjgnV7cidw8wrG9vahcbOHF3qw0z05UWwz0+1a4Q6gZXc4apg1uoNMuXcFyyfxo/gnFmFgqvDXnCG4XYAtOqxPlC6Pbsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=jhyYiY7A; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id EE20440E0169;
	Thu, 29 Aug 2024 14:14:35 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id PPqk9XZueheh; Thu, 29 Aug 2024 14:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1724940871; bh=NvPb2hh41oj+GB2wAGSBqKTolwm3KBz6DrPiss3p0fA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jhyYiY7AB6QXnLgtQN+qI65yiqX++U1JbFI/DPfg4JEA2Ouk9ccc3Dc5K91upUPhc
	 MzXY4kSWdHhmPLX9VntuznCckL3An6OAGd+8DEFLo17F8z2pk4eGfMN4kbnVJyHpih
	 /S94pBKc6fR6R8IxPNWNRK0YJzJaPvpypbU6CJVgp1urCHcWC+LNV054HZ568FjwvO
	 ApKqr9iu+Wo8b1ysW3+5+87FEr/jJrNROyZvRAqRM+LLWto8bpJhh+dpdmZ2ORZDfp
	 1oo/XaYSwROa+Wt65vjNceC1oVItuYpa571/ah65Z84XWJQX0N0Q2N2FfzRINQFi81
	 1Gxj+4ZZtVE/V84zFMG3oeEwLcd5k5sAppo2Q0/BcJJl2j0ibRC4BklorNuvzFKVyE
	 GJZFhfMtv3Hh92CgZP3m4u3Qb1B/3Gh5VAN58OZatnGoBj1Sa+BrSZh1K11ckizdXz
	 PSLBxj1XZfPNtJFzEshUqbHFgVeAyKl63dzcXjG4FUUyDdgvetSwvgStLgdJDkyejP
	 8lUrPSg4GvykbgWPTbgpKcp3dTdzMhlk6kS5dxBws5BMRdzLo0zeQ8eqbgdFt4XYB1
	 LgWcbjmQ0w1L8vy6JVTZEUUy1Y7gVJ4MJaCbXunCIw3CR8HpROeVbUpOqmZoJm2rj3
	 KSt4nRgM8wF6pYhpyn3SBV78=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8C44740E0277;
	Thu, 29 Aug 2024 14:14:22 +0000 (UTC)
Date: Thu, 29 Aug 2024 16:14:15 +0200
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, tony.luck@intel.com, x86@kernel.org,
	avadhut.naik@amd.com, john.allen@amd.com,
	boris.ostrovsky@oracle.com
Subject: Re: [PATCH] x86/MCE: Prevent CPU offline for SMCA CPUs with non-core
 banks
Message-ID: <20240829141415.GDZtCCN89eyjycV0uf@fat_crate.local>
References: <20240821140017.330105-1-yazen.ghannam@amd.com>
 <87jzg4g8dm.ffs@tglx>
 <20240826132057.GA449322@yaz-khff2.amd.com>
 <9D26E333-B33C-4FD4-9A8F-6F9DC1EC6527@alien8.de>
 <20240827134706.GA719384@yaz-khff2.amd.com>
 <7D571DAA-E399-4580-98B3-8A6E7085CB54@alien8.de>
 <20240829140305.GA448036@yaz-khff2.amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240829140305.GA448036@yaz-khff2.amd.com>

On Thu, Aug 29, 2024 at 10:03:05AM -0400, Yazen Ghannam wrote:
> Do you think we should we continue to pursue this or no?

You mean the kernel should prevent those folks from shooting themselves in the
foot?

How would that patch look like?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

