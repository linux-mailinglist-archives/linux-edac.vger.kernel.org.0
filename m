Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4647E1C5B60
	for <lists+linux-edac@lfdr.de>; Tue,  5 May 2020 17:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730004AbgEEPdF (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 5 May 2020 11:33:05 -0400
Received: from ms.lwn.net ([45.79.88.28]:50126 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730294AbgEEPdA (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 5 May 2020 11:33:00 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id D6C1331A;
        Tue,  5 May 2020 15:32:59 +0000 (UTC)
Date:   Tue, 5 May 2020 09:32:58 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Waiman Long <longman@redhat.com>
Cc:     Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        linux-edac@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] doc: Fix some typo errors in ras.rst
Message-ID: <20200505093258.77d052f5@lwn.net>
In-Reply-To: <20200505151049.11134-1-longman@redhat.com>
References: <20200505151049.11134-1-longman@redhat.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue,  5 May 2020 11:10:49 -0400
Waiman Long <longman@redhat.com> wrote:

> Fix typo errors.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  Documentation/admin-guide/ras.rst | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/admin-guide/ras.rst b/Documentation/admin-guide/ras.rst
> index 0310db624964..8b1803b2606f 100644
> --- a/Documentation/admin-guide/ras.rst
> +++ b/Documentation/admin-guide/ras.rst
> @@ -156,10 +156,10 @@ the labels provided by the BIOS won't match the real ones.
>  ECC memory
>  ----------
>  
> -As mentioned on the previous section, ECC memory has extra bits to be
> -used for error correction. So, on 64 bit systems, a memory module
> -has 64 bits of *data width*, and 74 bits of *total width*. So, there are
> -8 bits extra bits to be used for the error detection and correction
> +As mentioned on the previous section, ECC memory has extra bits to
> +be used for error correction. So, on 64 bit systems, a memory module
> +has 64 bits of *data width*, and 72 bits of *total width*. So, there
> +are 8 extra bits to be used for the error detection and correction
>  mechanisms. Those extra bits are called *syndrome*\ [#f1]_\ [#f2]_.

So I had to work to figure out what the change was, since you didn't say
in the changelog and you refilled the paragraph.  But this looks like a
*factual* error, giving the wrong number of bits, right?  It seems like
the changelog should say that.  Do the people who know about this stuff
agree that the change is correct?

Thanks,

jon
