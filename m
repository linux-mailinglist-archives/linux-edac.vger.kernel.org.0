Return-Path: <linux-edac+bounces-109-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB9E67FAAEB
	for <lists+linux-edac@lfdr.de>; Mon, 27 Nov 2023 21:05:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 289D71C20C37
	for <lists+linux-edac@lfdr.de>; Mon, 27 Nov 2023 20:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D1445BF6;
	Mon, 27 Nov 2023 20:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Yiy+P65B"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE5DBD4B;
	Mon, 27 Nov 2023 12:05:39 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B5E0840E01B1;
	Mon, 27 Nov 2023 20:05:37 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id OaPjmZ1M1Oyx; Mon, 27 Nov 2023 20:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1701115536; bh=we2GrIBLrlJSrltEodRDBQCzeU98z5V51twFBOzWnWI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Yiy+P65BxFi3hhHfD6nuN9QoHBR9tKOpXqXwOqvUXXY47gD0oH8uTkdI8+mzw6o1D
	 U5HYCxHgFd18gJB34UzayMQk48aXdQu9YtN1MXpVYk4ry4s9F1QGM8IlnzI8zxlt0w
	 8qOQI5J0SXuWvUSK7wDYv3uQyjFgIGarvHv186oZ0zbijTZi3gpHov20ybN0H87HPL
	 NjlYkJlO6WJcxwbXFT3xPiIm8ZAPesFSX40pCI0e0rA8897bt4VX9zse6PJYhBk3zo
	 vPCXoKOUjjsy1mFPXEOjyg+dSELToa2bKObPBc53ZvIR6g0fY+sjxBvsgNwzUHQVwG
	 RhUuH2D1UhuUuxMVYnfeyj//zxjSe+hmWAEiQNshPwakP/MW9i3UUrFtck0h2QGUTN
	 Ayj1rmRn9c6qH8Yy4vnGZl8atbipU3ZIRoOeg6OALXB8npd5fpcUma820nZACyRzOE
	 XX/T73MlF6Tn8EitUp4buoFK1BRE23Ii5N98rHYj67GTDeXYiO0lBHQN9PWFTKHhnS
	 CJ7L5WKpx7w858oMwofXRnY1SqWMlY0oEGfY+6UEYYTQ9EUY2ofPW8F+fpuBu8M1oG
	 bq3NgSIfj73VvNIwO21cUxQHftJV/DlR4VlL3pS0Wq2Zmh0PT/gZnCpV2XfZ1QxHzq
	 fR+g4O7xgQUzMRL1LzEtTO6E=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CB2D240E01A5;
	Mon, 27 Nov 2023 20:05:26 +0000 (UTC)
Date: Mon, 27 Nov 2023 21:05:19 +0100
From: Borislav Petkov <bp@alien8.de>
To: Abhinav Singh <singhabhinav9051571833@gmail.com>
Cc: tony.luck@intel.com, qiuxu.zhuo@intel.com, james.morse@arm.com,
	mchehab@kernel.org, rric@kernel.org, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] driver : edac : Fix warning using plain integer as NULL
Message-ID: <20231127200519.GHZWT2f2x76hMLR91V@fat_crate.local>
References: <20231109212157.1454726-1-singhabhinav9051571833@gmail.com>
 <20231127171435.GCZWTOe+DQSy4kkuKO@fat_crate.local>
 <dfb5b4cd-935c-445b-aaa7-bcce962a143d@gmail.com>
 <20231127183941.GGZWTibScFM4lgbqkG@fat_crate.local>
 <95fc95c8-dac6-4137-a9cd-29f27da64e41@gmail.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <95fc95c8-dac6-4137-a9cd-29f27da64e41@gmail.com>

On Tue, Nov 28, 2023 at 12:23:54AM +0530, Abhinav Singh wrote:
> Just to be correct this time, I need to put a reason why this needs to
> be fixed, in the patch itself, right?

No, the commit message is perfectly fine for that.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

