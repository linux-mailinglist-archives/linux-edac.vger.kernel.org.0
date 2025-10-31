Return-Path: <linux-edac+bounces-5275-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BC4BC251EE
	for <lists+linux-edac@lfdr.de>; Fri, 31 Oct 2025 13:57:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 842804F5792
	for <lists+linux-edac@lfdr.de>; Fri, 31 Oct 2025 12:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 525FE32720D;
	Fri, 31 Oct 2025 12:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="XsYJmiSk"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88413306D47;
	Fri, 31 Oct 2025 12:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761915305; cv=none; b=Nt490jPY4EaBadUn3+zCblamEZkq7TVjlwnsSAJPbcAVTNuBLtBFFlBuAvnGU7nZuZ5V4TRkhf5rwjr4DnoWHatzfdfmFha2CrEg9rtlN88amGPJ4zyOrIu2L86daiFvvhzT3NifTDxczWA2NST0oIdcmM+1sRPbvLxw/dnXD2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761915305; c=relaxed/simple;
	bh=mOOwivX1UoIsplCEE5dmAFDyJ2jcgv0YChQYja6+qqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AeuzRLdyEN66qQXFr+/jp8OtAKWmcpVT4oIcD8Z5CqVyEQFnJd6HjidTOPaTh1DeXX29nuwSxIUm+lOyB7K6Ppmlgf4C86kJPXwKlR9b7Cbb+bbHQyFIqSmRhXkf9nIskKMfcTmWUct6cyQ16BPo+YY45KTRFtqAxMfM2g6HhK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=XsYJmiSk; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8425B40E021A;
	Fri, 31 Oct 2025 12:55:00 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id cDkPO7uVnNoj; Fri, 31 Oct 2025 12:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1761915297; bh=twINoSEUBmO8uN9cB4cp2EUgBdLN58FZlTieTQpJHTY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XsYJmiSkD6gOzCdjHolSZ2lLWLSXYrCy7OeYIF3FLssgdpW9biLsx6Wfrvck5PM0k
	 cxoiIwZSfLzIWWojq4pk7lL5u+Qw+StPLKylDf1xOC4xXvZVOTmItH2BDFcg6lXgjU
	 kztiQO/chC/sDjFuJVMf/4QlO2FmXkuUgcEIBpmUiNXDUggSCYC7YXL2fT5EAWEA8w
	 Oyh2yEBthJhj14dfu45mAwBQnZfPuaXbopHf8n+OYMPZcXdbhMyUZ4H8d61ENmL1F8
	 41WMnN24ipu6TZvKqUl3whjpFhrAFV2ly21MNc+da2LSBMdfw2VIwNCnVcmLxJuOqo
	 sfXN1Jennop0cK4lYziJFNtshN+EyWRrp65uRkr+pYBcLw88k/0CxXsk3xFOYUAYLy
	 nhDvs43Up3B0n1fn94AvuilLq+3RJdMqfxP0fH19NNfHzrCMmG3pthNk6fKTMnIVgM
	 THwbMRuQCTYV1dMX2jrZCnoDgP0UBHfSbby6825hn6fAfWW30sN81GE9BwXl9/qWYO
	 LPFMvzZfrhVMZ4gNL9wCxhFUpBbHlk+4SlaX8A679SEYNTvDLCpOGTAaWdExxLPQnL
	 4y63F3AaJtWRIvLqRvfDNWPsioxFDMSgw5cb8ia9NZr1CXE8HbUmpQNaVdYwUVHDRh
	 lEbt2OqdbVJ031guBrnqysDs=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id DE66940E016D;
	Fri, 31 Oct 2025 12:54:51 +0000 (UTC)
Date: Fri, 31 Oct 2025 13:54:46 +0100
From: Borislav Petkov <bp@alien8.de>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Avadhut Naik <avadhut.naik@amd.com>, linux-edac@vger.kernel.org,
	yazen.ghannam@amd.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] EDAC/mc_sysfs: Begin deprecating legacy sysfs EDAC
 interface
Message-ID: <20251031125446.GDaQSxllGS9N84L2sK@fat_crate.local>
References: <20251013173632.1449366-1-avadhut.naik@amd.com>
 <20251013173632.1449366-5-avadhut.naik@amd.com>
 <20251029172419.GGaQJNw4Pofl1x1mve@fat_crate.local>
 <2025103029-reforest-negate-cc34@gregkh>
 <20251030191858.GEaQO6ImJ4fbqB_5ag@fat_crate.local>
 <2025103150-subside-tux-fd46@gregkh>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2025103150-subside-tux-fd46@gregkh>

On Fri, Oct 31, 2025 at 01:38:57PM +0100, Greg KH wrote:
> Yup!

Thanks.

@Avadhut: you can send the next revision now. :)

Thx.


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

