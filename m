Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16D7B131297
	for <lists+linux-edac@lfdr.de>; Mon,  6 Jan 2020 14:10:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbgAFNKA (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 6 Jan 2020 08:10:00 -0500
Received: from mail.skyhub.de ([5.9.137.197]:49886 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726467AbgAFNKA (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 6 Jan 2020 08:10:00 -0500
Received: from zn.tnic (p200300EC2F270F00D01C7B5BCA520F19.dip0.t-ipconnect.de [IPv6:2003:ec:2f27:f00:d01c:7b5b:ca52:f19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DCC231EC03AD;
        Mon,  6 Jan 2020 14:09:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1578316198;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=lWa/DEYSm8nKdl5gwoKmWpRa3Mo12FbsP/q+yLT9OE8=;
        b=e5OsSmbxS1duTWmwLnWMSnKCG9ubd+hCPC/562BMf7jyjbJG9PU81rWjwioPqF41trISQt
        1hni2fgKsrdUTR0anu2f5/NjCayKQdBvteU72sUQKnz1jdEAd+xHqoDn8NybNJ6MJVIZoz
        3Squ+v/orzb+M6TjU9wEE8Qvcy1J0gw=
Date:   Mon, 6 Jan 2020 14:09:49 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Bhaskar Upadhaya <bhaskar.upadhaya.linux@gmail.com>
Cc:     Bhaskar Upadhaya <bupadhaya@marvell.com>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-edac@vger.kernel.org, lenb@kernel.org, rafael@kernel.org,
        gkulkarni@marvell.com, rrichter@marvell.com
Subject: Re: [RFC PATCH] apei/ghes: fix ghes_poll_func by registering in
 non-deferrable mode
Message-ID: <20200106130949.GD12238@zn.tnic>
References: <1576652618-27017-1-git-send-email-bupadhaya@marvell.com>
 <20200102180130.GG8345@zn.tnic>
 <CAEYJA6oXTxTmJEji5_Hup2oB+GrgGnmSTiS-nNuzbNzGJ9VESA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAEYJA6oXTxTmJEji5_Hup2oB+GrgGnmSTiS-nNuzbNzGJ9VESA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Jan 06, 2020 at 04:33:19PM +0530, Bhaskar Upadhaya wrote:
> Definition of poll interval as per spec (referred ACPI 6.3):
> "Indicates the poll interval in milliseconds OSPM should use to
> periodically check the error source for the presence of an error
> condition."

Please add that...

> We are observing an issue in our ThunderX2 platforms wherein
> ghes_poll_func is not called within poll interval when timer is
> configured with TIMER_DEFERRABLE flag(For NO_HZ kernel) and hence we
> are losing the error records.

... and that to your commit message then, so that it is crystal clear
*why* you're making this change.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
