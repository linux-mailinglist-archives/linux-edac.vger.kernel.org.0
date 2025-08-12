Return-Path: <linux-edac+bounces-4568-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 264F9B238A8
	for <lists+linux-edac@lfdr.de>; Tue, 12 Aug 2025 21:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71A8A7222E5
	for <lists+linux-edac@lfdr.de>; Tue, 12 Aug 2025 19:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB9202FD1C5;
	Tue, 12 Aug 2025 19:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sj+eHPKz"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9257F2F8BC3;
	Tue, 12 Aug 2025 19:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755026647; cv=none; b=G9+5V4vNRVBnqzEobmg3Wewz1GCI0azNTBw8vL0J/h9M2C9KEAmecdoi7Yii+fJQpTf0xmZrytRcY+A2t0yltKyAMoMw5lQyC6fd9aW028WoNz899pWqieWzarWe3PprZGwJCZUxHS3cF/FtVFEF3hU+kagMh0fUm1S+yvNetPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755026647; c=relaxed/simple;
	bh=xJKYOxUWkPZ3nmqmyRsauTD2N7Zyq6ecCwpko7Jpu+M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FdWACO5yKKCxoA3Yrk5Au7wd7D3SILyZZB8ZADOz/GTQkSqmMFkBSxfGW/WqPXrG065ow40w2haRV2M+VS/Vo5LuTy+BhnQP5XAUGF8Fabm/sE8JpPOP577mCXsvcjYKQGDbPaOteF8YsmmawXe6tmO4QeO3r8Ps6yI0HV1XifE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sj+eHPKz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E2F2C4CEF4;
	Tue, 12 Aug 2025 19:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755026647;
	bh=xJKYOxUWkPZ3nmqmyRsauTD2N7Zyq6ecCwpko7Jpu+M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sj+eHPKzi4lnxnUtytBWZa/RjWt4wpZFiMhFmH2pPKmFPN+YoZmS1qpvmckNGaXPK
	 z/lYmJezGczjR7PCuMnfx+GOrZ+u2Echk6c74OdP72tFXkA5X1gTgFFwHTsK++PcXW
	 XmGdGPq8bs5EuO8ZcxXZq9Fs8dWHOtHTzovR2ZataMdtcTmiwWUeogufJXY9ZSYMZV
	 HXltP0AlX48QSPX8JEI3gXJPuGOnKuT+9UbJjsHYYk9lRlsMY0ZZUjeiOURnu/JMCG
	 XafKqyl7h/RUgreakPkdEXipd7z+vWcHyDUQdth3astZeQ6m61hOfW7kW0lcmPdYAd
	 G4iPa2hjmcZUA==
Date: Tue, 12 Aug 2025 21:23:59 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Jakub Kicinski <kuba@kernel.org>, EDAC
 Mailing List <linux-edac@vger.kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Doc Mailing List
 <linux-doc@vger.kernel.org>, Akira Yokosawa <akiyks@gmail.com>, "David S.
 Miller" <davem@davemloft.net>, Ignacio Encinas Rubio
 <ignacio@iencinas.com>, Marco Elver <elver@google.com>, Shuah Khan
 <skhan@linuxfoundation.org>, Donald Hunter <donald.hunter@gmail.com>, Eric
 Dumazet <edumazet@google.com>, Jan Stancek <jstancek@redhat.com>, Paolo
 Abeni <pabeni@redhat.com>, Ruben Wauters <rubenru09@aol.com>,
 joel@joelfernandes.org, linux-kernel-mentees@lists.linux.dev,
 lkmm@lists.linux.dev, netdev@vger.kernel.org, peterz@infradead.org,
 stern@rowland.harvard.edu, Breno Leitao <leitao@debian.org>, Simon Horman
 <horms@kernel.org>
Subject: Re: [GIT PULL for v6.17-rc2] add a generic yaml parser integrated
 with Netlink specs generation
Message-ID: <20250812212359.6e905337@foz.lan>
In-Reply-To: <e8731f6f-9057-46f0-8df0-7ece500c0928@infradead.org>
References: <20250812113329.356c93c2@foz.lan>
	<87h5ycfl3s.fsf@trenco.lwn.net>
	<e8731f6f-9057-46f0-8df0-7ece500c0928@infradead.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Aug 2025 11:41:58 -0700
Randy Dunlap <rdunlap@infradead.org> wrote:

> On 8/12/25 11:31 AM, Jonathan Corbet wrote:
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
> > ...it might be nice to get that straightened out.  
> 
> I see it, at least in linux-next. However, its format is
> "different," so that may have confused whatever printed
> that message:
> 
> from Documentation/networking/index.rst:
> 
>    filter
>    generic-hdlc
>    generic_netlink
>    netlink_spec/index
>    gen_stats
>    gtp
>    ila

Maybe some merge conflict/merge issue, as this was renamed:

$ git show 1ce4da3dd99e98bd4a8b396c291041080e0fe85e Documentation/networking/index.rst
commit 1ce4da3dd99e98bd4a8b396c291041080e0fe85e
Author: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Date:   Thu Jun 12 10:34:30 2025 +0200

    docs: use parser_yaml extension to handle Netlink specs
    
    Instead of manually calling ynl_gen_rst.py, use a Sphinx extension.
    This way, no .rst files would be written to the Kernel source
    directories.
    
    We are using here a toctree with :glob: property. This way, there
    is no need to touch the netlink/specs/index.rst file every time
    a new Netlink spec is added/renamed/removed.
    
    Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
    Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

diff --git a/Documentation/networking/index.rst b/Documentation/networking/index.rst
index ac90b82f3ce9..b7a4969e9bc9 100644
--- a/Documentation/networking/index.rst
+++ b/Documentation/networking/index.rst
@@ -57,7 +57,7 @@ Contents:
    filter
    generic-hdlc
    generic_netlink
-   netlink_spec/index
+   ../netlink/specs/index
    gen_stats
    gtp
    ila

Thanks,
Mauro

