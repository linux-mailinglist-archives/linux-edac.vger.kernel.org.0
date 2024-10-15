Return-Path: <linux-edac+bounces-2072-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9A499E313
	for <lists+linux-edac@lfdr.de>; Tue, 15 Oct 2024 11:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F2471C21BB3
	for <lists+linux-edac@lfdr.de>; Tue, 15 Oct 2024 09:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E63241DF261;
	Tue, 15 Oct 2024 09:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Z+6wr2fC"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA1818B488;
	Tue, 15 Oct 2024 09:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728985759; cv=none; b=V0eC1/3IfXzICI4j8IkWr0QfClzNg05VZWt1WAHIxoceOAcbNFVpDZ5rMUYfKUaAqJO0GgN45buAe/3LvxD+P3ZKiYxdP5mEsBNwNlbnOgmTBE57DVuLbZIGSEKZmt/Ngl8G+Sus9oNGqBp0gG7GzUK07RCFIkBpRM+0kAhERJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728985759; c=relaxed/simple;
	bh=pkfmR86OLnLflTvdgJ9gzMh0Z9LchJNRWECKaDZz6OQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uUaISoqcT/AmLxGCvyX4DCnYerUdbwJ1TSxShaxhllqQqxEEKsd1oGOwkr3insAytlVLPgqtrGC5SmSbwdh//rgtZCeVvI77cMoZ4DOHYsFOGUAXy/7hkF3OoC8s6etllP+03SUL5we0L4IIy+vA2n9YTkHc32xAHP582iE7sUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Z+6wr2fC; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6977440E01A5;
	Tue, 15 Oct 2024 09:49:13 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id RDGTe0vdMgzz; Tue, 15 Oct 2024 09:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1728985748; bh=Lwyk6dqtr7douMO9sTb0q4k/d7+lucp4olJGes24ZKM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z+6wr2fCWcN7NxjV2gLBlDR2ZIkUsxGW2YbCCNhqTlDNBF4TOlJkO9MMzGG/n0RqP
	 J+RZnIeo2TkRdUofHSjYHykMbIkt6ZmHK9eMatG214fJA+UHJihZ2sGqNSGwf6Yv14
	 0IidpmyhCSWEuhRjGT4hGJjwj1vtreCKPUwivoMvul7R70TwHF+G7iRT4DHvi/mhWm
	 FOxC8EWptJXFTlm3OinccDTT0S5U9Nw0tNS0473cBMEnsz9lZ085tD2taDrjGXFVPs
	 Sef6eziy8AOJaBQ7eoXNmhsISYRSL669ChJ+hxVjza1yh8VSpJ73kRWd3R+pfLnwC3
	 26F/CbH2fap/1qOse7+4fwUfDHG9tDWu2LhfCA9R/eXIxB2Yjc23Mc0phc6E8LCMed
	 3rH1/CqduFpOkivyQmmq6+Bd6Nu98Pzt6Wi6pmseQKJiqquBRYG3S2GQjljXyJ/j9l
	 +PuOkL342QMGILMrvynG6aKz4FjJYIYLA8HclFIFLjcVA3Lt1eHudgSM6eWuuWvPqh
	 XQcg5TXFke3trKS378NfW27ym2eHK5SNM27g9YiOdm51jsGTVwFdXBjxvg74/Zi6Dq
	 z19oYO8B0lw+DKw7QRB1pjKwwC/uL76tWCYO1krDO12tUoUhHZ5/5FaPdi6FYJTK7L
	 Wo0wuQD/3mPZrq2AAJ/ALP0s=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 695D740E0184;
	Tue, 15 Oct 2024 09:48:49 +0000 (UTC)
Date: Tue, 15 Oct 2024 11:48:43 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
Cc: Avadhut Naik <avadhut.naik@amd.com>, "x86@kernel.org" <x86@kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Luck, Tony" <tony.luck@intel.com>,
	"rafael@kernel.org" <rafael@kernel.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>,
	"lenb@kernel.org" <lenb@kernel.org>,
	"mchehab@kernel.org" <mchehab@kernel.org>,
	"james.morse@arm.com" <james.morse@arm.com>,
	"airlied@gmail.com" <airlied@gmail.com>,
	"yazen.ghannam@amd.com" <yazen.ghannam@amd.com>,
	"john.allen@amd.com" <john.allen@amd.com>,
	"avadnaik@amd.com" <avadnaik@amd.com>
Subject: Re: [PATCH v5 1/5] x86/mce: Add wrapper for struct mce to export
 vendor specific info
Message-ID: <20241015094843.GAZw46e6KKVjigUatc@fat_crate.local>
References: <20241001181617.604573-1-avadhut.naik@amd.com>
 <20241001181617.604573-2-avadhut.naik@amd.com>
 <CY8PR11MB713406B2C492D55428397AFA89452@CY8PR11MB7134.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CY8PR11MB713406B2C492D55428397AFA89452@CY8PR11MB7134.namprd11.prod.outlook.com>

On Tue, Oct 15, 2024 at 06:53:41AM +0000, Zhuo, Qiuxu wrote:
> The word 'mce' isn't too long. IMHO using 'mce' instead of 'm' as
> a variable name is more meaningful :-).
> 
>     struct mce mce;

No, this is not better. Because sometimes it is ambiguous whether the struct
"mce" is meant or the variable "mce".

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

