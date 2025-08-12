Return-Path: <linux-edac+bounces-4565-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEFA3B22FC4
	for <lists+linux-edac@lfdr.de>; Tue, 12 Aug 2025 19:44:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADD4F565368
	for <lists+linux-edac@lfdr.de>; Tue, 12 Aug 2025 17:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B212FDC34;
	Tue, 12 Aug 2025 17:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BT40vCBP"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7A32FD1D6;
	Tue, 12 Aug 2025 17:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755020593; cv=none; b=S3bCJ+zrwW/48zTI36RTowBkotz1aO6X2Dpnf2ecPMnLENqvHHhXTHwJ1BI1Y4ziFZLsAilTK/QKLjiY6KpnYVLYj0rszTDFdbwQYUDH6pTpRSNEHjzerwqXxNEK9JZkUcxk6+7/7dtlU3GvHNxNCJVF1br6Lv/hUJNO0FEPUkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755020593; c=relaxed/simple;
	bh=+9VxjHXMYKIJPxkzz610EA5fxF2cM2YNhxrdq0v1LLA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zl4UJ1fTQtuVhjsGJVOktYbt3Onv+4/+UBBlfRu39rQTSEPA1oHj2t926XcyT5rBVT4VfUFk5n4TynOQF0YRUKvb+lvmfkjiP+vvcPbErJrSSgBiGF1U5/9S834riwimy/kedu2FnJjGnHtUxb6Xp75YRLN3iCaRE9l4kJncNjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BT40vCBP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 729D2C4CEF0;
	Tue, 12 Aug 2025 17:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755020593;
	bh=+9VxjHXMYKIJPxkzz610EA5fxF2cM2YNhxrdq0v1LLA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BT40vCBPhEZY7aGVH77x4TqYZngNxzoIilVLHAoRNyaEeFvYIPx00lsibqF74FUzX
	 0HXQZ8h9yhvTMxBC36KKxk0aZITS+0vIcQijFzusKTSDxqNXuciqMsLJPylEAJG6tH
	 PEnQgU/mXa7fo2SLHMjCmNTRQZETy0cXJDOQMthF2ZOUT/W9SJoItVDIZF+qrZKMSD
	 woKt5HW0IIAU9GXKS0iukSvptuVtkmtEILY+5NJsp3C998D0fst06x3dtuEGyk/bd8
	 HTagI8z21WfG4wb9PlX0xO9o9c+CE6dJn5CLIQegxh0XIpiRn+sPfz5n/nXQ5V47aY
	 gectQAuMDXDPQ==
Date: Tue, 12 Aug 2025 10:43:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, EDAC Mailing List
 <linux-edac@vger.kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Doc Mailing List
 <linux-doc@vger.kernel.org>, Akira Yokosawa <akiyks@gmail.com>, "David S.
 Miller" <davem@davemloft.net>, Ignacio Encinas Rubio
 <ignacio@iencinas.com>, Marco Elver <elver@google.com>, Shuah Khan
 <skhan@linuxfoundation.org>, Donald Hunter <donald.hunter@gmail.com>, Eric
 Dumazet <edumazet@google.com>, Jan Stancek <jstancek@redhat.com>, Paolo
 Abeni <pabeni@redhat.com>, Ruben Wauters <rubenru09@aol.com>,
 joel@joelfernandes.org, linux-kernel-mentees@lists.linux.dev,
 lkmm@lists.linux.dev, netdev@vger.kernel.org, peterz@infradead.org,
 stern@rowland.harvard.edu, Breno Leitao <leitao@debian.org>, Randy Dunlap
 <rdunlap@infradead.org>, Simon Horman <horms@kernel.org>
Subject: Re: [GIT PULL for v6.17-rc2] add a generic yaml parser integrated
 with Netlink specs generation
Message-ID: <20250812104311.08fd0695@kernel.org>
In-Reply-To: <20250812113329.356c93c2@foz.lan>
References: <20250812113329.356c93c2@foz.lan>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Aug 2025 11:33:29 +0200 Mauro Carvalho Chehab wrote:
> The patch content is identical to my v10 submission:
> 
> 	https://lore.kernel.org/linux-doc/cover.1753718185.git.mchehab+huawei@kernel.org/

Thank you! We'll merge on Thu, FWIW, after we fast forward to Linus.

