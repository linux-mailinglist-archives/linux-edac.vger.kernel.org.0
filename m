Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF25E3E5E17
	for <lists+linux-edac@lfdr.de>; Tue, 10 Aug 2021 16:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239443AbhHJOgp (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 10 Aug 2021 10:36:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:58786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237490AbhHJOgo (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 10 Aug 2021 10:36:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 410BB60EB5;
        Tue, 10 Aug 2021 14:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628606182;
        bh=ABqs84wKaUA3FByRyPz8v+wtP3BKrfJzJu/RCm8D2Ns=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tnMmTlYPtbMjowAzEOmV/NIhYmZfApYgdV5s/JLl5d4j6aQDcoY/FVPk4kTDWjvhe
         lLFSd1kaqo0joYIwZj/S1k7o/0ihHd8At7bwyS55M/ksf8xofcKco0LSMUSSPOzLyy
         zP43WWqXDJ2U/y1uRSZnmT84RigA4ULEdOJJxqst//wjsOiDio2IcU/EI1RAsmMZJw
         QkA4bYBsIIbJIIKcg4CVxaMqOigT904GRlqSe90RwsijWz+X/DWyeCTZdWzYqFYVsu
         tRncrUBw/vqgZyhaCG5RKslAwIN2dxhMFjaz8D0rLgWZGGGG36GJPGf5zL1waM/sxl
         BuNFWfiQxBCQA==
Date:   Tue, 10 Aug 2021 16:36:16 +0200
From:   Robert Richter <rric@kernel.org>
To:     Joe Perches <joe@perches.com>
Cc:     Len Baker <len.baker@gmx.com>, Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] drivers/edac/edac_mc: Remove all strcpy() uses
Message-ID: <YRKO4An9UkObVGmB@rric.localdomain>
References: <20210807155957.10069-1-len.baker@gmx.com>
 <ff02ffffdc130a772c01ec0edbf8d1e684b0730a.camel@perches.com>
 <20210808112617.GA1927@titan>
 <YRD90L6PMoVbbv+9@rric.localdomain>
 <99448ef29830fda9b19409bc23b0e7513b22f7b7.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99448ef29830fda9b19409bc23b0e7513b22f7b7.camel@perches.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 09.08.21 10:18:58, Joe Perches wrote:

> strscpy and scnprintf have different return values and it's simpler
> and much more common to use scnprintf for appended strings that are
> limited to a specific buffer length.

Calculating the bytes written from the return value is a oneliner.

-Robert
