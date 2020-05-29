Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFACE1E7906
	for <lists+linux-edac@lfdr.de>; Fri, 29 May 2020 11:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725821AbgE2JI0 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 29 May 2020 05:08:26 -0400
Received: from mail.skyhub.de ([5.9.137.197]:45850 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725795AbgE2JIZ (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 29 May 2020 05:08:25 -0400
Received: from zn.tnic (p200300ec2f0f5e00e15a1b2e1d2ace20.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:5e00:e15a:1b2e:1d2a:ce20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 699DF1EC03D2;
        Fri, 29 May 2020 11:08:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1590743304;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IJP6lsPlOHbBYdYzMrExdaBcUaoETZOJCOfJtwZHJtM=;
        b=F94mshD6g/b6QYHowTW0BziskDTE7S2WtnON+pw0gpe9SroiAsIX5e1+OAbpfbBbF2gvcY
        kcxl7KcBbn6WNEmnqTrOBQU2scCn4tw8MBZAuHjpBTaMoPampqnvJEP7sU6iGo5z/CJNux
        JPDBeE35HQ8q5mZ1G+VeShMMjmqITa0=
Date:   Fri, 29 May 2020 11:08:24 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Markus Elfring <Markus.Elfring@web.de>,
        Qiushi Wu <wu000273@umn.edu>
Cc:     linux-edac@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Doug Thompson <dougthompson@xmission.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Morse <james.morse@arm.com>, Kangjie Lu <kjlu@umn.edu>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rrichter@marvell.com>,
        Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH] edac: Fix reference count leak in
 edac_device_register_sysfs_main_kobj()
Message-ID: <20200529090824.GB9011@zn.tnic>
References: <77d6b960-aedc-c7ce-5df9-f3653bfd500a@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <77d6b960-aedc-c7ce-5df9-f3653bfd500a@web.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, May 29, 2020 at 10:45:08AM +0200, Markus Elfring wrote:
> Would you like to indicate with such information (according to
> the topic “net-sysfs: Fix reference count leak in rx|netdev_queue_add_kobject”)
> that your issue was detected also with the help of the kernel fuzzing
> tool “syzkaller”?

There's no need for any commt reference - there's text over
kobject_init_and_add() explaining what you need to do when that function
fails.

> How do you think about to add an imperative wording to the change description?

His commit message is fine.

> Will it be helpful to combine this update step together with
> “edac: Fix reference count leak in edac_pci_main_kobj_setup”
> into a small patch series?

Just combine them into one patch.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
