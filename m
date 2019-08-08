Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B710686468
	for <lists+linux-edac@lfdr.de>; Thu,  8 Aug 2019 16:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732239AbfHHOeo (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 8 Aug 2019 10:34:44 -0400
Received: from mail.skyhub.de ([5.9.137.197]:59686 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728718AbfHHOen (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 8 Aug 2019 10:34:43 -0400
Received: from zn.tnic (p200300EC2F0FD700329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:d700:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 82AAC1EC0B07;
        Thu,  8 Aug 2019 16:34:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1565274882;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RBnElMqX2QUiWIbxlRKCB/aJ7LHhc2Uta1rn6iNlw6A=;
        b=p+svPhNMadJDVgXsvdYmF08Uf7P9Me+EOmXtzi4POasnQ79+cixwnaPCOovt6xzThs9zZ3
        jvr33Wg89g8qn5VHx4VE++sVFeCRkwsZz9hZtTzs5vrkkTeB8AYb1jvpO3kLrzhaNgnu6f
        iWP8vjAEdOhFOIsW12ZeBygBOvBZbR4=
Date:   Thu, 8 Aug 2019 16:35:27 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>
Cc:     Tony Luck <tony.luck@intel.com>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] drivers/ras: Don't build debugfs.o if no debugfs
 in config
Message-ID: <20190808143527.GG20745@zn.tnic>
References: <7053.1565218556@turing-police>
 <20190808093101.GE20745@zn.tnic>
 <77171.1565269299@turing-police>
 <20190808142055.GF20745@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190808142055.GF20745@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Aug 08, 2019 at 04:20:55PM +0200, Borislav Petkov wrote:
> On Thu, Aug 08, 2019 at 09:01:39AM -0400, Valdis Klētnieks wrote:
> > It's needed if somebody applies the patch 2/2 -
> 
> It is needed for what?

Nevermind, saw the 0day build bot mail.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
