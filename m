Return-Path: <linux-edac+bounces-5274-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42DB9C250B9
	for <lists+linux-edac@lfdr.de>; Fri, 31 Oct 2025 13:39:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89AE31897F13
	for <lists+linux-edac@lfdr.de>; Fri, 31 Oct 2025 12:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6716F329E47;
	Fri, 31 Oct 2025 12:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="e+ysPSfu"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374B61C28E;
	Fri, 31 Oct 2025 12:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761914341; cv=none; b=PYltm7/X8c4nLoCoxry+pHbYlohTk3X1ZWePqgKZWweehyRns0tNSt7yHIUINXnKkxJ1Tx7A3V1mffEJj2X1H17p9MxRL2ZMQCU793yVo5e8+vQfPHsCDPQGc5IAcyfwhzf+oceU87TojateFaN5lVwsKoCkSCf4Uxo0000LcZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761914341; c=relaxed/simple;
	bh=gxgnWkdOyiGUoiNKkes6YJ/qXMfJLU1DXX/Btzew2wE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mfOjqIfdrcrV/YSpzWsKD7ncdQZZEqFl5lucxO34Qi+c2hJ/ueI2w1DtqQnjI5ppObk51oD6KClYYZN6pBq0NsdqV8orpOxH3Cp9r/oVG9BPhWklhapmZ2uiv1bV0S1fJK7wyBDMhD9Bh+33TphAxZ6J38EHfjJAjy1BeYZc8DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=e+ysPSfu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60CEBC4CEE7;
	Fri, 31 Oct 2025 12:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761914340;
	bh=gxgnWkdOyiGUoiNKkes6YJ/qXMfJLU1DXX/Btzew2wE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e+ysPSfugIGUrkQpt6JwWovpHV7pOL+NYze6gAJd08GEF7LED3hWtEnFxoOfso6NA
	 mZGc+j5/CbFR2/PzB9FErfN6sTvw1MSB3DXhlg/1QD5DiA9QIChxAHZ/IKPayH44IN
	 OcrQy39oxxdrwBODuvZ67VKhQ/oI7c65+2Zh6eF0=
Date: Fri, 31 Oct 2025 13:38:57 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Avadhut Naik <avadhut.naik@amd.com>, linux-edac@vger.kernel.org,
	yazen.ghannam@amd.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] EDAC/mc_sysfs: Begin deprecating legacy sysfs EDAC
 interface
Message-ID: <2025103150-subside-tux-fd46@gregkh>
References: <20251013173632.1449366-1-avadhut.naik@amd.com>
 <20251013173632.1449366-5-avadhut.naik@amd.com>
 <20251029172419.GGaQJNw4Pofl1x1mve@fat_crate.local>
 <2025103029-reforest-negate-cc34@gregkh>
 <20251030191858.GEaQO6ImJ4fbqB_5ag@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251030191858.GEaQO6ImJ4fbqB_5ag@fat_crate.local>

On Thu, Oct 30, 2025 at 08:18:58PM +0100, Borislav Petkov wrote:
> On Thu, Oct 30, 2025 at 04:01:43PM +0100, Greg KH wrote:
> > No one is going to notice this type of kernel log message.  If you think
> > that no one is using the sysfs files, delete them now.  Why wait?
> > 
> > sysfs is meant to be such that userspace can handle file removals (i.e.
> > that value is not present.)  Unfortunately, sometimes this does not
> > actually happen and user tools do mess up and rely on things.  So either
> > no one uses the file and it can be removed now, OR you have to leave it
> > in for "forever".  There's no real chance to remove it later, that's
> > just postponing the decision.
> 
> Lemme try to repeat what you're proposing to make sure we're on the same page:
> 
> we simply zap the files and see if anyone complains. If yes, we figure out why
> they're using them and if they can't be moved to the new interface, we restore
> them and maintain them forever.
> 
> Right?

Yup!


