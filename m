Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03FF212E9A1
	for <lists+linux-edac@lfdr.de>; Thu,  2 Jan 2020 19:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727905AbgABSBn (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 2 Jan 2020 13:01:43 -0500
Received: from mail.skyhub.de ([5.9.137.197]:54980 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727890AbgABSBn (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 2 Jan 2020 13:01:43 -0500
Received: from zn.tnic (p200300EC2F00E700329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f00:e700:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7A2E51EC0419;
        Thu,  2 Jan 2020 19:01:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1577988097;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=tT0jvwjEfaD2BIfE3OdrlYZgbSWvbo0cYYcu6rKbP80=;
        b=PQAb8bkB51WAgC5xGXXhFRDSY09onyZvEJoWoMXreMVZWQWnzog+GHEVELPv7STBa53feX
        MK6obYcvNOZIc5L1kHTN9iKY6PAf+I37Xc4/aMJ135WO9SQOwrstgKhttGgydPvPidAaDy
        z7rYqs+AuvvPDKmA53Ia+Y26j/90+uI=
Date:   Thu, 2 Jan 2020 19:01:30 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Bhaskar Upadhaya <bupadhaya@marvell.com>
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-edac@vger.kernel.org, lenb@kernel.org, rafael@kernel.org,
        gkulkarni@marvell.com, rrichter@marvell.com,
        bhaskar.upadhaya.linux@gmail.com
Subject: Re: [RFC PATCH] apei/ghes: fix ghes_poll_func by registering in
 non-deferrable mode
Message-ID: <20200102180130.GG8345@zn.tnic>
References: <1576652618-27017-1-git-send-email-bupadhaya@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1576652618-27017-1-git-send-email-bupadhaya@marvell.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Dec 17, 2019 at 11:03:38PM -0800, Bhaskar Upadhaya wrote:
> Currently Linux register ghes_poll_func with TIMER_DEFERRABLE flag,
> because of which it is serviced when the CPU eventually wakes up with a
> subsequent non-deferrable timer and not at the configured polling interval.
> 
> For polling mode, the polling interval configured by firmware should not
> be exceeded as per ACPI_6_3 spec[refer Table 18-394],

I see

"Table 18-394 Hardware Error Notification Structure"

where does it say that the interval should not be exceeded and what is
going to happen if it gets exceeded?

IOW, are you fixing something you're observing on some platform or
you're reading the spec only?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
