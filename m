Return-Path: <linux-edac+bounces-1047-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 959418C318D
	for <lists+linux-edac@lfdr.de>; Sat, 11 May 2024 15:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 294DC281E60
	for <lists+linux-edac@lfdr.de>; Sat, 11 May 2024 13:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3E050A8F;
	Sat, 11 May 2024 13:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="QMDxiaPP"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BAD50A6E;
	Sat, 11 May 2024 13:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715432904; cv=none; b=rHk1q07MMCI4PCXyVVEkRi/o8GLI2COYaYJKfK6xExhFn7aWzBqRKfuWfn5lSkibPTh0CW9187VgxL1gxS112O0bOM9ty/RpZVgrFFAzjdlQPhISwuJFjscqjWeXbUmz9+6jimycRqQSyh+2Tk/nNursw2fpeBnayJ4VbZffA4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715432904; c=relaxed/simple;
	bh=VkukmLqoNf0vM3tHlbUPLF8zbaFjlYyVWkV0/NzvKko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=anp1xxXAWXtZkjGPiGHeLuRIMDlrckBXTgvz9Yy5H7jzMX8YHcwR4k6b2L3rIU68XxzYzPRt/z0e28cfhXXE3fVfWrY540GS02I5bils7Sj03pqaffs3RO6XS6p3QWx/YTaSKTPXYQMSlOSmz3yvk4YtjsXMmTgPsZZ6HP4qopI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=QMDxiaPP; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9919F40E01A1;
	Sat, 11 May 2024 13:08:19 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id WVSMvkQIl5QV; Sat, 11 May 2024 13:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1715432896; bh=ecSaKsp0uVZzm2MoFq8UJY3XN8cj8gw46icOK5RxnC8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QMDxiaPP5ldgNbHz0TcicT+aWjo9iMRpVOxy/Jt+df/CSgJ/rfgha2rjhA/zxR4fQ
	 4Zt6gKISfh8yfkkC2Kbj8E8gbQ03UINJ5PDAW8E5nEVosS0NQogiFLH/s06eh15GO9
	 S39VSeMyJ+Q/CZDBIOh6sHwYxu1m9EM9DF41b4qYVnyhXCi3HV9+SsnWD6MBvQSILa
	 3iYhgCJrwF7xtRVpGIh/9DlgVNfX+G1NPPwvmrZ2sr3wCCegR6FBpEKt89WOnc+VgD
	 EGkVfBx7QcXWxAhsthIrSlTvnPY50noaiIpiSUpRlTt5dgY1/D2EzO/GkZRVxXf3SB
	 J5JDsKJE5GT1IlNiIZRAVVWybTR0KUFWoObU9wa/jSsR93zFzvRpqUnefFngRpMsVv
	 MkJ//z3m7gXzXEYqEcfVf/n+xSZvH10H81KVi70CwT60F+h2Q3BpaH5OGDWUd8+gSP
	 hk6L7xS4nZVPwqPuBRoOWZDbcHS16TDHGZYy6QJ1byxpb81wb4I/Zg7muN3LTnv+0k
	 RtG7EseYgemaHnVqgfd814Tx2vJOBlphh/SIPzXQ9p2Oqvd8czfTv2mm3lKBCnlZDC
	 ollKHiKh+F7AE/88PJ41jlaqCkuQzbzrGuET+n50w9nPHbntOqC0TVNcDoBkMYw/V1
	 S3RIVy5joi4VMSmnfYctgMog=
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4FE6D40E016A;
	Sat, 11 May 2024 13:08:08 +0000 (UTC)
Date: Sat, 11 May 2024 15:08:01 +0200
From: Borislav Petkov <bp@alien8.de>
To: Dan Williams <dan.j.williams@intel.com>
Cc: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-edac@vger.kernel.org
Subject: Re: [RFC PATCH v2 3/3] ACPI: extlog: Make print_extlog_rcd() log
 unconditionally
Message-ID: <20240511130801.GBZj9tsenZ5SKXgRTm@fat_crate.local>
References: <20240510112740.667445-1-fabio.m.de.francesco@linux.intel.com>
 <7009544.jJDZkT8p0M@fdefranc-mobl3>
 <20240510192556.GDZj50xFIWSqK2gzQR@fat_crate.local>
 <2881368.Ex9A2HvPv6@fdefranc-mobl3>
 <663e9bd4c2525_db82d29451@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <663e9bd4c2525_db82d29451@dwillia2-xfh.jf.intel.com.notmuch>

On Fri, May 10, 2024 at 03:12:36PM -0700, Dan Williams wrote:
> I had asked Fabio to take a look at whether it made sense to continue
> with the concept of ras_userspace_consumers() especially since it seems
> limited to the EXTLOG case.
> 
> In general I am finding that between OS Native and Firmware First error
> reporting the logging approaches are inconsistent.
> 
> As far I can see rasdaemon would not even notice is the "daemon_active"
> debugfs file went away [1],

It tells the kernel that it is consuming the error info from the
tracepoints.

> and it should be the case that the tracepoints always fire whether
> daemon_active is open or not.
>
> So I was expecting this removal to be a conversation starter on the
> wider topic of error reporting consistency.

Yeah, and then they'll come and say: ew, we're getting error duplicates
- once logged in dmesg and once through the tracepoints.

So just like with the other thread, we have to figure out what our
scheme will be wrt hw error logging, agree on it and then make it
consistent.

Do we want to have both? Should it be configurable? Probably...

Anything else...?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

