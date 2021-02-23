Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8A8A322B5F
	for <lists+linux-edac@lfdr.de>; Tue, 23 Feb 2021 14:26:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232749AbhBWNZT (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 23 Feb 2021 08:25:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232671AbhBWNZS (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 23 Feb 2021 08:25:18 -0500
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3E14BC061574;
        Tue, 23 Feb 2021 05:24:37 -0800 (PST)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 2425092009C; Tue, 23 Feb 2021 14:24:36 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 1671092009B;
        Tue, 23 Feb 2021 14:24:36 +0100 (CET)
Date:   Tue, 23 Feb 2021 14:24:36 +0100 (CET)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-mips@vger.kernel.org, Tiezhu Yang <yangtiezhu@loongson.cn>,
        Willy Tarreau <w@1wt.eu>, linux-edac@vger.kernel.org,
        linux-hams@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] arch: mips: update references to current linux-mips
 list
In-Reply-To: <20210223122928.GD7765@alpha.franken.de>
Message-ID: <alpine.DEB.2.21.2102231423070.1900@angie.orcam.me.uk>
References: <20210222161905.1153-1-lukas.bulwahn@gmail.com> <20210222161905.1153-4-lukas.bulwahn@gmail.com> <20210223122928.GD7765@alpha.franken.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, 23 Feb 2021, Thomas Bogendoerfer wrote:

> For the other patches I'll wait for how the resolution for linux-mips.org
> looks like.

 FWIW I think the typo fix in 5/5 is obviously correct and can go in right 
away.  We can deal with the LMO reference later on should it be needed.

  Maciej
