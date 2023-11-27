Return-Path: <linux-edac+bounces-112-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EEF07FAB84
	for <lists+linux-edac@lfdr.de>; Mon, 27 Nov 2023 21:29:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4FBB281B67
	for <lists+linux-edac@lfdr.de>; Mon, 27 Nov 2023 20:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9364145BFB;
	Mon, 27 Nov 2023 20:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="W3xQZQIr"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50961213D;
	Mon, 27 Nov 2023 12:29:24 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 23A4440E014B;
	Mon, 27 Nov 2023 20:29:22 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id HmRgVQpxgJoJ; Mon, 27 Nov 2023 20:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1701116960; bh=9o90y7uPExEKDmbrwbYNOtkKrtsYcSyqQQMMMrciv6k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W3xQZQIrgfMNcBS7lIhwiWushgkauirF0aFNnJA6M9PWpbZmkIa5LlxCpVxik5Ip9
	 DykpDcgKodAGOFWV9gGExx1D/SqSp4lbJJEg07uUCwL3sNarq4IfF1C/0Ko04duEJQ
	 Dz2dJK35+q4qd74Ynj0UCYBcU/DQXSN5iuzom2ehdbNz/iZYLwQvD5TiOhtJu944Lw
	 y3Rr5mrZIM7e2oXUn+/zrN9EyOGvZKrdT5CLXQrzrn0uDjmSZgOwgwYk1CDdIb/4aD
	 enGAwtLBusbEnmPiOG5PSOpz96EHdezzu+opbvv0PKS5M1hujI6d2oY0ftApBvLpp+
	 flSw6VZX8udjwbagr9YDWb4r+1Kx9pIsXs/f8wmDxoB49hEuIUCKm1x88HFJTNluoa
	 zPi0ALRmHoWSHdrjwJsbKGgbOiv4ZT877wB4FfKiLkpCefLn4IKTXkhkVNjdqotoRG
	 OBrnxOTYKPu6K+L4GHDro/reejKFKSS1riyUvLESXTPG5krVSRBjS9QimA+/D6pDVT
	 cJX1SuCnKyFEnCS/ven/reYJPt8f0NnV9bdCevos7D4Aqaq00bsQv/FAH5c4qVneaM
	 mF1yd1r5qjdstZY5TbW2NbZnwuqlwBsvYzQkoOaEGhpHQ5mK4E4cbUrcbW0kANPeBk
	 Rxdhp155vd36hBIu/sEbu3KQ=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2E06C40E0031;
	Mon, 27 Nov 2023 20:29:11 +0000 (UTC)
Date: Mon, 27 Nov 2023 21:29:06 +0100
From: Borislav Petkov <bp@alien8.de>
To: Abhinav Singh <singhabhinav9051571833@gmail.com>
Cc: tony.luck@intel.com, qiuxu.zhuo@intel.com, james.morse@arm.com,
	mchehab@kernel.org, rric@kernel.org, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] driver : edac : Fix warning using plain integer as NULL
Message-ID: <20231127202906.GIZWT8EgKxGzLQTRtw@fat_crate.local>
References: <20231109212157.1454726-1-singhabhinav9051571833@gmail.com>
 <20231127171435.GCZWTOe+DQSy4kkuKO@fat_crate.local>
 <dfb5b4cd-935c-445b-aaa7-bcce962a143d@gmail.com>
 <20231127183941.GGZWTibScFM4lgbqkG@fat_crate.local>
 <95fc95c8-dac6-4137-a9cd-29f27da64e41@gmail.com>
 <20231127200519.GHZWT2f2x76hMLR91V@fat_crate.local>
 <af489962-705f-4a72-943d-ba3b46d64597@gmail.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <af489962-705f-4a72-943d-ba3b46d64597@gmail.com>

On Tue, Nov 28, 2023 at 01:49:06AM +0530, Abhinav Singh wrote:a
> Okay, so I guess as of now there is no change needed, so I need not
> send a v2 patch, right?

As of now, you should go back and reread the whole thread.

I'm going to give you one last example and then stop:

Imagine one fine day you're doing git archeology, you find the place in
the code about which you want to find out why it was changed the way it
is now.

You do git annotate <filename> ... find the line, see the commit id and
you do:

git show <commit id>

You read the commit message and there's just gibberish and nothing's
explaining *why* that change was done. And you start scratching your
head, trying to figure out why. Because the damn commit message is worth
sh*t.

This happens to us maintainers at least once a week. Well, I don't want
that to happen in my tree anymore.

You catch my drift? :)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

