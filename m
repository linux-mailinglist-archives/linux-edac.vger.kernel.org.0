Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17E1A13DF40
	for <lists+linux-edac@lfdr.de>; Thu, 16 Jan 2020 16:51:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbgAPPvW (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 16 Jan 2020 10:51:22 -0500
Received: from mail.skyhub.de ([5.9.137.197]:41954 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726151AbgAPPvW (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 16 Jan 2020 10:51:22 -0500
Received: from zn.tnic (p200300EC2F0B23002957B4D0D21CE7EE.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:2300:2957:b4d0:d21c:e7ee])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 03DF71EC071C;
        Thu, 16 Jan 2020 16:51:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1579189881;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Wgupd+vOvik6VGLiIGC59MyorQUoRE4q6Dw4T3BddQQ=;
        b=B9PDoURNxaeK1V/0ll4/vaNNTUmNSiwgq4cI9FHPlIp1aDBaATDHydkLzH8Ndhp6avesjO
        gz/3Z4Inhx8fZT01x84RQc0XDsnM5LXKslNcWt4l7AMYYInV+m/9rbWTULvtzpgJEcGTpD
        WtUurxpcw50qhYomFLN6n9rjZB0ctqo=
Date:   Thu, 16 Jan 2020 16:51:16 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <Yazen.Ghannam@amd.com>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        bp@suse.de, tony.luck@intel.com, x86@kernel.org
Subject: Re: [PATCH 1/5] x86/MCE/AMD, EDAC/mce_amd: Add new Load Store unit
 McaType
Message-ID: <20200116155116.GE27148@zn.tnic>
References: <20200110015651.14887-1-Yazen.Ghannam@amd.com>
 <20200110015651.14887-2-Yazen.Ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200110015651.14887-2-Yazen.Ghannam@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Jan 10, 2020 at 01:56:47AM +0000, Yazen Ghannam wrote:
> From: Yazen Ghannam <yazen.ghannam@amd.com>
> 
> Future SMCA systems may see a new version of the Load Store unit bank
		      ^^^^^^^^

Yah, you've been hanging around with hw people too much. I can just as
well reply: "well, I'll apply the patch when I see future SMCA systems"
:-)

All I'm saying is, forget those "may" formulations when it comes to
kernel patches. :-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
