Return-Path: <linux-edac+bounces-4570-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86871B24264
	for <lists+linux-edac@lfdr.de>; Wed, 13 Aug 2025 09:17:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93DC81894137
	for <lists+linux-edac@lfdr.de>; Wed, 13 Aug 2025 07:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 281692D3ED5;
	Wed, 13 Aug 2025 07:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ObG88ZVD"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59AC27280E;
	Wed, 13 Aug 2025 07:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755069334; cv=none; b=fvLuQPgmoFgFmI3qOhT56cLQc/7ntLLA+CJnqe6kuhKmWPBcAhk7MbCnhQ8OT2FDF/+Pj/SvO3f0iUcqKIwlnJvH7j13QifE6WEy0o+7RpdMjKGvP9ClR8XIIBvzFOjsHsP09vzTyNss5D1VWh7ubaJ0uAMaoiVz10MwqsMIpHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755069334; c=relaxed/simple;
	bh=elyY9ghlBiJMOHD++SOe+6pqUXWxKIEdZXVjZCLz+sc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qHu/Levu4quoERuEXk/jWai6XKqYMkAV7yeFjFhoyRRaPqz5EKpPXna0s+t8V+hcnAC75d29vSXDN4GDm3pPWtzoHYVMqSTOv4n9vaXD771SSgMsuxmGICz/7g6cfAZLyY2L+qR1H5OGi1uSbIP2ESUpdq84qNo4TcdYu02YuXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ObG88ZVD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 810C2C4CEEB;
	Wed, 13 Aug 2025 07:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755069333;
	bh=elyY9ghlBiJMOHD++SOe+6pqUXWxKIEdZXVjZCLz+sc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ObG88ZVDFDiK9kpiT80O1dSFdLPYvljQKn8GyW5wJLAoWXWw7pJBdD0fmtj+ztTLb
	 Wi9kk2jSZrUqu1RL/XNzZz6Hq66IvZCRR88T9e3MAnGGFjMA81TTSM4E3j2PuwlDKP
	 +DsEmTZAm1SrJ1Vz5EFQE4LnsDfl5b2O4p950k+wC2nkDlHceN7t0BpAvni/ibKceI
	 qhAO5zw0/X68BAR1rpHvXd6yk7FaARgdRtjvwYXdai/udbcEAn9t7WE3EWG7rsvoxX
	 Rko2uqfd2Nl+qc6KC9tp611a9g+OIPDRQfVwPm2eSd59eJo1w7V3ioC0XL3HdyGhV5
	 vbp8yNlAlEDLQ==
Date: Wed, 13 Aug 2025 09:15:26 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Akira Yokosawa <akiyks@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Jakub Kicinski <kuba@kernel.org>, EDAC
 Mailing List <linux-edac@vger.kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Doc Mailing List
 <linux-doc@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Ignacio Encinas Rubio <ignacio@iencinas.com>, Marco Elver
 <elver@google.com>, Shuah Khan <skhan@linuxfoundation.org>, Donald Hunter
 <donald.hunter@gmail.com>, Eric Dumazet <edumazet@google.com>, Jan Stancek
 <jstancek@redhat.com>, Paolo Abeni <pabeni@redhat.com>, Ruben Wauters
 <rubenru09@aol.com>, linux-kernel-mentees@lists.linux.dev,
 netdev@vger.kernel.org, Breno Leitao <leitao@debian.org>, Randy Dunlap
 <rdunlap@infradead.org>, Simon Horman <horms@kernel.org>
Subject: Re: [GIT PULL for v6.17-rc2] add a generic yaml parser integrated
 with Netlink specs generation
Message-ID: <20250813091526.3cf39352@foz.lan>
In-Reply-To: <9c4a655e-095b-45fe-b35d-c3f0ae6a9237@gmail.com>
References: <20250812113329.356c93c2@foz.lan>
	<87h5ycfl3s.fsf@trenco.lwn.net>
	<9c4a655e-095b-45fe-b35d-c3f0ae6a9237@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Aug 2025 11:49:50 +0900
Akira Yokosawa <akiyks@gmail.com> wrote:

> [-CC: LKMM folks and list; this has nothing to do with the memory model]
> 
> Hi Jon,
> 
> On Tue, 12 Aug 2025 12:31:03 -0600, Jonathan Corbet wrote:
> > Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:
> >   
> >> Hi Jon/Jakub,
> >>
> >> In case you both prefer to merge from a stable tag, please pull from:
> >>
> >> 	git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-docs.git docs/v6.17-1
> >>
> >> For:
> >>
> >> - An YAML parser Sphinx plugin, integrated with Netlink YAML doc
> >>   parser.  
> > 
> > OK, I have done that.  I will note that it adds a warning:
> >   
> >> Documentation/networking/netlink_spec/index.rst: WARNING: document isn't included in any toctree  
> > 
> > ...it might be nice to get that straightened out.  
> 
> After the merge, "git status" complains:
> 
>     Untracked files:
>       (use "git add <file>..." to include in what will be committed)
> 	Documentation/networking/netlink_spec/
> 
> So, I don't think there is anything you can do in the Git repo side ...
> 
> We need to remember to "rm -rf" the directory after crossing this merge
> point.
> 
> In theory, such "rm -rf" could be added somewhere in Documentation/Makefile,
> but that would not work well with write-protected shared kernel repos.

And this is actually what started this patch series: the original
approach of auto-generating and writing files under
Documentation/networking/netlink_spec/ is problematic: a patch
that renamed some files caused the past version of the generated
files to generate warnings.

So, yeah, with the old approach one needs to manually clean up
Documentation/networking/netlink_spec/ if this was not the first
time doc were built on a git clone instance.

Btw, before my patch series, there was the cleandocs target
was:

	YNL_INDEX:=$(srctree)/Documentation/networking/netlink_spec/index.rst
	YNL_RST_DIR:=$(srctree)/Documentation/networking/netlink_spec
	YNL_YAML_DIR:=$(srctree)/Documentation/netlink/specs
	YNL_RST_FILES_TMP := $(patsubst %.yaml,%.rst,$(wildcard $(YNL_YAML_DIR)/*.yaml))
	YNL_RST_FILES := $(patsubst $(YNL_YAML_DIR)%,$(YNL_RST_DIR)%, $(YNL_RST_FILES_TMP))

	cleandocs:
		$(Q)rm -f $(YNL_INDEX) $(YNL_RST_FILES)
		$(Q)rm -rf $(BUILDDIR)
		$(Q)$(MAKE) BUILDDIR=$(abspath $(BUILDDIR)) $(build)=Documentation/userspace-api/media clean

It means that, with the old approach, the safe way to apply
patches that touch YAML Netlink (YNL) is to do:

	make cleandocs			# remove old auto-generated patches from /Documentation/networking/netlink_spec
	<apply new series>
	make htmldocs

to ensure that the previous auto-generated files were removed.

Thanks,
Mauro

