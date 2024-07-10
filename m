Return-Path: <linux-edac+bounces-1492-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6487692D48C
	for <lists+linux-edac@lfdr.de>; Wed, 10 Jul 2024 16:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 954AB1C20F99
	for <lists+linux-edac@lfdr.de>; Wed, 10 Jul 2024 14:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C2C193060;
	Wed, 10 Jul 2024 14:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="e5UByNJ1"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5FA15E97
	for <linux-edac@vger.kernel.org>; Wed, 10 Jul 2024 14:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720623160; cv=none; b=t3eXlOVb6U3ER28ri8E28TmC2MgfA7/x+Yq0wIEtX00FCOk3IuC6E2GH7+/x8sxa8YJTYaprczPU/sgrfRdnGdCuCsxLOjUMO4P3s4Uw0d5ra9nzYNuUHFFWZi+sPBvYhyhzqufaO9I2EZLHIRyAT4VH2O3h1Yjuaqf6rElTJQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720623160; c=relaxed/simple;
	bh=HjG0cnkhuaOoq0FI3rtT6zr9IM/miwXQetxhpoC+KJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KWVt9sd+vt7/wAU9jQc2IAvbThfjHu+zRRG5QXgFXBV9e6oimW26zKnOofRSF1cug8/pLFbMy24pSbW8gqavQrQaAzXrB2jm/Jy5rO/SGBAl95LdnEeZYER41/TFAy0PZujui0kKOnSYqcpQCOHkORj4GMH/CGmqjP+ex7r02CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=e5UByNJ1; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 71F3940E0219;
	Wed, 10 Jul 2024 14:52:28 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id rE_3jiVbCC3Y; Wed, 10 Jul 2024 14:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1720623144; bh=y8NR8qL4ObcJ8uM4zTsndIip7gtxhuuRGU7TVFirUMM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e5UByNJ1qXlTw6K9LuXTIjtSyI0GkLpm0iUIo0QxQkQnF35bt1AEt5IO8KIMFRvSd
	 HMK3/ll5wT6EI8vBb/F8CoBhT6CRJ+B5vi/YVCAl/M5x3FdgoeCBkgf4k3OpXHqjha
	 ChF6JeiZsmVI6l/zDwYUwzzieHxEO+XBmwGcWGEUYfAfgWzqzYY59emWFqOeWEgmep
	 iPo/e8CcyKvPqRczEZcZuuB/9fJ8OBfdlTL8vC2gJdwdzEfS35tEJGBKM/1NJLILFz
	 MaiSRajFyM3Z53McpdSzxJqbXdtc4npSfdhzkxKZZTpIj9THD348XeOxkuvfMATSOS
	 z4aiG/yi58r8glBewQGTvhBvBiigxIKPV2+UGiuTKnDfVJkvnczsdpZv0BV6iLGksu
	 FJzt7Y4LdA/8G/kP/afK/Y4g8DnC0+vXSia0DrG+99v/EWRCCNMHri05MhbXr1fh8n
	 4ZQZg7JEStQmqBS4rNNFf6f+FppmOtzsYWn2Tpu5NGavX13K152zyDGLYrb+Pkt/pM
	 fIozZPu/EKsZuQafhMyKQjfl+EqmoLPPbzGTrr6JnEXYLyUnTB2Fu7zjj3nJE7tlCh
	 aW6+2hOLucK28MwOqi0K6O94SSSCoDEvaPjqGKemnTEbMcakGIoEgIBAFsneICJEJu
	 1a12fFo5RAnfyUYJeMNAyDTY=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7D23240E019D;
	Wed, 10 Jul 2024 14:52:18 +0000 (UTC)
Date: Wed, 10 Jul 2024 16:52:13 +0200
From: Borislav Petkov <bp@alien8.de>
To: Andrew Zaborowski <andrew.zaborowski@intel.com>
Cc: linux-edac@vger.kernel.org, linux-mm@kvack.org,
	Kees Cook <keescook@chromium.org>, Tony Luck <tony.luck@intel.com>,
	Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH 1/3] x86: Add task_struct flag to force SIGBUS on MCE
Message-ID: <20240710145213.GFZo6gHT_Jj14lKhMI@fat_crate.local>
References: <20240710125445.564245-1-andrew.zaborowski@intel.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240710125445.564245-1-andrew.zaborowski@intel.com>

On Wed, Jul 10, 2024 at 05:54:43AM -0700, Andrew Zaborowski wrote:
> This e-mail and any attachments may contain confidential material for
> the sole use of the intended recipient(s). Any review or distribution
> by others is strictly prohibited. If you are not the intended
> recipient, please contact the sender and delete all copies.

Now deleted.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

