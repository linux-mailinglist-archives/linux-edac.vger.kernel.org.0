Return-Path: <linux-edac+bounces-5414-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 19842C4171C
	for <lists+linux-edac@lfdr.de>; Fri, 07 Nov 2025 20:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4641A4EA07F
	for <lists+linux-edac@lfdr.de>; Fri,  7 Nov 2025 19:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD86C305066;
	Fri,  7 Nov 2025 19:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="k8jTzFPQ"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A72D2DEA80;
	Fri,  7 Nov 2025 19:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762543849; cv=none; b=S2KzkPbWsCkdSY5jwWNuunqmW0Mh8VM+tq5piQgMqBIIAd/yOzTL607BYyy4uF+K6X7BTPWxefzfk6WoLhdsL6DuVLcL82lJnGSl9eSp4xYwIbLHmabU+QVtSOU2kvM8T5JmOEj4khYk8FpXjheiVwzaVvhzNC0FQmW1tNh9kGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762543849; c=relaxed/simple;
	bh=GskO2h9wIb6SPHoA/5pHXkzC4O6zASQ0Yt8CLP+3dAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BfUfLZ9RKH0AoV7QWDZeErw0HWgOtEGFgIlo/8Q9lwJJcOLGKLXhMVtldcjSMYAgvPZmb0NDbiDNIKRWAB3V8JfO5Y2aZwn4uhYJYM45Lnfp5+HyKRpbvj+YicWx9MKE01WJSaG6SmjREb9ft7c9XH8yCcfXZXB4C6CMX/Pl1xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=k8jTzFPQ; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6557740E019D;
	Fri,  7 Nov 2025 19:30:44 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id hRwvGZIqEm7N; Fri,  7 Nov 2025 19:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1762543841; bh=nvfMzttWB81WPeHCL4vBFk6WtiBVPUZbizCeeSkxrD8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k8jTzFPQxp6Yo+2WcT1jnavsVJTjyoxaXklgkN1iZ8JuPx6miIx69p8aZ4OywKuNl
	 E7SImcN+nw438lcms7htdMDwUosjeul2nwwLT2bZLkAg4BKdXQj5w8MCKbNlVpyMCK
	 wmVtWo/OnHRw2J4WVCJbQ/BQneM8IplSJqRBGxdarYZV/AjBnN+0vSCbm2I3nxJDiK
	 f5wGm6CsXas+ps71ifjM8lZiUKu5fksgjnaQX5Ri66uqW9LMg2D1HwlFyAEIEAyTl7
	 ZD8d+/R286B1QRQhQXzb710hOwLlwxxTfBz0+3FI23MQil00pdNH2aYcHBsyBFx/Ft
	 g1KFNbWv/GvvrGlq9zDFKXKaKnflU5F4hFZh7De3dHU6w6a1+JJmkW/Vo3+E1Atbn4
	 RioElPa0gLY6Niv7kYlHbfrR6P+9l9T/MXNsyuIuAIgJ31Eskbp2wL+mvqeQY32DVR
	 T9ZjYwmjLlEoKzvENaFWddbTXsUMveoeK+h6JxtEMjsiFSbLcmgYbIUbHr9zP/qH2q
	 MJRqzB+khgf5AWEtsahmpRYq282bDgXbPK9ri7fRz/vM2AgtIkCPGbA/7BdZ0o+nSc
	 fXVlpJZK6tGT7FyGZBiWuLpeC8XUetYGBU6NGMsBGUWhj2SGqyuCzf445hd5l8NjJ3
	 2ZdSJkmKGGmhrrGcbKXZr0xA=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id EFCF640E015B;
	Fri,  7 Nov 2025 19:30:31 +0000 (UTC)
Date: Fri, 7 Nov 2025 20:30:24 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Datta, Shubhrajyoti" <shubhrajyoti.datta@amd.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"git (AMD-Xilinx)" <git@amd.com>,
	"shubhrajyoti.datta@gmail.com" <shubhrajyoti.datta@gmail.com>,
	Tony Luck <tony.luck@intel.com>, James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>
Subject: Re: [PATCH] EDAC/versalnet: Handle split messages for non-standard
 errors
Message-ID: <20251107193024.GDaQ5I0J7-T-HvZqr9@fat_crate.local>
References: <20251023113108.3467132-1-shubhrajyoti.datta@amd.com>
 <20251029130832.GBaQIR0CF8kSl6exi7@fat_crate.local>
 <LV5PR12MB9828A123A3ADFA1EB177E58681F8A@LV5PR12MB9828.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <LV5PR12MB9828A123A3ADFA1EB177E58681F8A@LV5PR12MB9828.namprd12.prod.outlook.com>

On Fri, Oct 31, 2025 at 09:41:58AM +0000, Datta, Shubhrajyoti wrote:
> > I'm guessing you want to move that comment too?
> >
> > If so, I can move it - you don't have to resend.
> 
> Thanks for the catch . I agree.

Queued, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

