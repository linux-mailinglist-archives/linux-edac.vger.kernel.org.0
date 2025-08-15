Return-Path: <linux-edac+bounces-4596-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A948DB2741A
	for <lists+linux-edac@lfdr.de>; Fri, 15 Aug 2025 02:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D554C17E8C2
	for <lists+linux-edac@lfdr.de>; Fri, 15 Aug 2025 00:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD537DA93;
	Fri, 15 Aug 2025 00:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VR0a7B/T"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0399456448;
	Fri, 15 Aug 2025 00:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755218414; cv=none; b=NpcqPlSt34nXJ/J2KVipXwHu4uJalQJa3gmrTPGE+cQ1qmeAkOOimcgxXcTeWToR3wi2Hm/ZmD6zunfMieUP/1K5lyC1R1IaOXoD/zn4lE8wgfcLWbraa9Ykbxojzkk7KrDSQgrfw8cEY87cXrRC52k+uynUSOmKBwx5fseV+Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755218414; c=relaxed/simple;
	bh=VtBcS/tV0m2U4pYJvwPUfbWhsXX/BnwpCuWbChCDYMQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=D02WnNundGIGtOztpvqMv53HZL3odiogsC9lDQ5dKxJA4U8LyrCdNV4r6DyVE5HETgQ531OjNyw4sAP6FJaGN5ZKzZGg9wz7Db4Ge15tCAgoJelO3epYieIqDSXggN5cyKv5JZpllk/Z4U+u4xEszhJMKQnqFs5ZhArFbY74rGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VR0a7B/T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D794C4CEED;
	Fri, 15 Aug 2025 00:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755218413;
	bh=VtBcS/tV0m2U4pYJvwPUfbWhsXX/BnwpCuWbChCDYMQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VR0a7B/TF8qjkwlYQfhLD4NS+l9mO2v16Zt7mQSwTd2zXN4680OTYMhsgF902ttwO
	 ZMoJVFe3dbLecS5t2K1ZpsP0LxocmhRd9pOdUwV39z+KO9AqsQOOcDggqVFahsUPAw
	 iPv0yBfL4j2wVS02748DylwwM7C7Ez7klGNCPgi92iv/5X7PoDXBoCo+dOlPKPsQyr
	 KvQH0q73EKi2cbB/8/jt1ZyylX4Ex640kopjuRJlLiusq3+fFzBg4rBy1eMiKR0eeM
	 kxEAt/AzIXUuYSbez/Tezp5Y7tb6aw1a+6Kju6ykFAqyjILUglP60QlmEFW46VTY3D
	 p81dPo0ZWWA8A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE2D39D0C3E;
	Fri, 15 Aug 2025 00:40:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL for v6.17-rc2] add a generic yaml parser integrated
 with
 Netlink specs generation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175521842474.497413.14612774027751914766.git-patchwork-notify@kernel.org>
Date: Fri, 15 Aug 2025 00:40:24 +0000
References: <20250812113329.356c93c2@foz.lan>
In-Reply-To: <20250812113329.356c93c2@foz.lan>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: corbet@lwn.net, kuba@kernel.org, linux-edac@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, akiyks@gmail.com,
 davem@davemloft.net, ignacio@iencinas.com, elver@google.com,
 skhan@linuxfoundation.org, donald.hunter@gmail.com, edumazet@google.com,
 jstancek@redhat.com, pabeni@redhat.com, rubenru09@aol.com,
 joel@joelfernandes.org, linux-kernel-mentees@lists.linux.dev,
 lkmm@lists.linux.dev, netdev@vger.kernel.org, peterz@infradead.org,
 stern@rowland.harvard.edu, leitao@debian.org, rdunlap@infradead.org,
 horms@kernel.org

Hello:

This pull request was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 12 Aug 2025 11:33:29 +0200 you wrote:
> Hi Jon/Jakub,
> 
> In case you both prefer to merge from a stable tag, please pull from:
> 
> 	git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-docs.git docs/v6.17-1
> 
> For:
> 
> [...]

Here is the summary with links:
  - [GIT,PULL,for,v6.17-rc2] add a generic yaml parser integrated with Netlink specs generation
    https://git.kernel.org/netdev/net-next/c/c4f72d3747ac

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



