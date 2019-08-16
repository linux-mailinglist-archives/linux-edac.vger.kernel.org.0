Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E78E8FF7B
	for <lists+linux-edac@lfdr.de>; Fri, 16 Aug 2019 11:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbfHPJzP (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 16 Aug 2019 05:55:15 -0400
Received: from mail.skyhub.de ([5.9.137.197]:54000 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726842AbfHPJzP (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 16 Aug 2019 05:55:15 -0400
Received: from zn.tnic (p200300EC2F0A920014AE47D987991812.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:9200:14ae:47d9:8799:1812])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 023921EC074B;
        Fri, 16 Aug 2019 11:55:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1565949314;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=XweYhjF+rXykrgPaapT+0IRgJwtUWbywHZya/wVe2z8=;
        b=HU2hDoO/gvHu/qH+BDbnS23Qq8G1b2bQEtB5/fuw6HXflolKiNqJgFmoiadTD0h+9iv076
        kGjxSWWVNVVRAlfyeLxqSAbo7nlijvNXvyAFFUgtFye496BCbqhoDE5o34FP7k1Z1UBZee
        QGgBkGSLywIPsqz0QGWWv0mrlCnYkT4=
Date:   Fri, 16 Aug 2019 11:55:59 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Robert Richter <rrichter@marvell.com>
Cc:     James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 13/24] EDAC, ghes: Add support for legacy API counters
Message-ID: <20190816095559.GL18980@zn.tnic>
References: <20190624150758.6695-1-rrichter@marvell.com>
 <20190624150758.6695-14-rrichter@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190624150758.6695-14-rrichter@marvell.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Jun 24, 2019 at 03:09:22PM +0000, Robert Richter wrote:
> The ghes driver is not able yet to count legacy API counters in sysfs,
> e.g.:
> 
>  /sys/devices/system/edac/mc/mc0/csrow2/ce_count
>  /sys/devices/system/edac/mc/mc0/csrow2/ch0_ce_count
>  /sys/devices/system/edac/mc/mc0/csrow2/ch1_ce_count
> 
> Make counting csrows/channels generic so that the ghes driver can use
> it too.

What for?

ghes_edac enumerates the DIMMs from SMBIOS - it doesn't need chip
selects and ranks. Those are used when you can't count the DIMMs
properly...

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
