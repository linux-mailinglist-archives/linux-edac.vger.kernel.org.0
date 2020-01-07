Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA245133035
	for <lists+linux-edac@lfdr.de>; Tue,  7 Jan 2020 21:02:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728379AbgAGUCN (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 7 Jan 2020 15:02:13 -0500
Received: from mail.skyhub.de ([5.9.137.197]:57262 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728358AbgAGUCN (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 7 Jan 2020 15:02:13 -0500
Received: from zn.tnic (p200300EC2F0FB400453AE1B66C2BC925.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:b400:453a:e1b6:6c2b:c925])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7B0701EC0CD3;
        Tue,  7 Jan 2020 21:02:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1578427331;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ysOcvAqAKnTyDEY5Saj0YcqW5rlYPZb9UU4KflK5iSs=;
        b=LJrGoOQaZjEMccNlBstQ3nCwxvQ+RFSVIczJtEam+HYzGJ++W8NhjF62U9KL5vhcEkS4xI
        sUhutd8vR2MkV21jR9aMhawxREor8jTEqEo9/gr9gDd3z3ZTW+YMmBEXdhqSjAb7++KNXW
        qSZ3zJ7GRA5JK7xo4Hf87moF6gemf8E=
Date:   Tue, 7 Jan 2020 21:02:08 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Robert Richter <rrichter@marvell.com>,
        Bhaskar Upadhaya <bhaskar.upadhaya.linux@gmail.com>
Cc:     Bhaskar Upadhaya <bupadhaya@marvell.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        Ganapatrao Prabhakerrao Kulkarni <gkulkarni@marvell.com>
Subject: Re: [RFC PATCH] apei/ghes: fix ghes_poll_func by registering in
 non-deferrable mode
Message-ID: <20200107200208.GN29542@zn.tnic>
References: <1576652618-27017-1-git-send-email-bupadhaya@marvell.com>
 <20200102180130.GG8345@zn.tnic>
 <CAEYJA6oXTxTmJEji5_Hup2oB+GrgGnmSTiS-nNuzbNzGJ9VESA@mail.gmail.com>
 <20200106130949.GD12238@zn.tnic>
 <CAEYJA6rPiBYnM4rT5WJnvTSrk6GBHeLYxK5OF5oxmeVxVepGGQ@mail.gmail.com>
 <20200107130421.6w67frcsllkblie2@rric.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200107130421.6w67frcsllkblie2@rric.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Jan 07, 2020 at 01:04:29PM +0000, Robert Richter wrote:
> > Thanks Borislav, I will edit the commit message with you comments in
> > the next patch.
> > Can I get your Ack in the next patch ?

Acks are being given when the new version arrives. Look at LKML archives
for examples.

> I guess Boris will apply the patch to his tree as maintainer, so no
> need to ack it.

Nah, apei/ghes stuff goes through Rafael. I'm just a reviewer for the
APEI side.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
