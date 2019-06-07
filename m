Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD46839238
	for <lists+linux-edac@lfdr.de>; Fri,  7 Jun 2019 18:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729953AbfFGQh0 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 7 Jun 2019 12:37:26 -0400
Received: from mail.skyhub.de ([5.9.137.197]:58232 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728595AbfFGQhZ (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 7 Jun 2019 12:37:25 -0400
Received: from zn.tnic (p200300EC2F066300951FA2F4E0AD5C5F.dip0.t-ipconnect.de [IPv6:2003:ec:2f06:6300:951f:a2f4:e0ad:5c5f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D8A1E1EC051F;
        Fri,  7 Jun 2019 18:37:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1559925444;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=7WjY5qaAv27ValKhUMq1yIoenSZ2j62xBkezoiC69Zs=;
        b=jMmWqc0rhKCK86ZQ6PX3bL6zsRp1FkI1o6MsFq1LkWHQN3VXu8MgR7qG6uhMI1Qd1WW6IY
        wrhpnqzTi5Fnz0OHUP4vpXcC9ZmMhi1YlKqMq5A2dr+AQYO2XAvlnVSeGCKwFcIS/nRYMV
        umWHi4erwF+jEu6tg26waThTvyjfIdE=
Date:   Fri, 7 Jun 2019 18:37:23 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v3 5/6] x86/MCE: Save MCA control bits that get set in
 hardware
Message-ID: <20190607163723.GG20269@zn.tnic>
References: <20190517163729.GE13482@zn.tnic>
 <20190517172648.GA18164@agluck-desk>
 <20190517174817.GG13482@zn.tnic>
 <20190517180607.GA21710@agluck-desk>
 <20190517193431.GI13482@zn.tnic>
 <SN6PR12MB2639C5427366AC3004C35CC0F80B0@SN6PR12MB2639.namprd12.prod.outlook.com>
 <20190517200225.GK13482@zn.tnic>
 <SN6PR12MB26390759DB43763D3A482918F8010@SN6PR12MB2639.namprd12.prod.outlook.com>
 <20190527232849.GC8209@cz.tnic>
 <SN6PR12MB263998ECCDF1E345FEB0869AF8100@SN6PR12MB2639.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SN6PR12MB263998ECCDF1E345FEB0869AF8100@SN6PR12MB2639.namprd12.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Jun 07, 2019 at 02:49:42PM +0000, Ghannam, Yazen wrote:
> Would you mind if the function name stayed the same? The reason is
> that MCA_CTL is written here, which is the "init" part, and MCA_STATUS
> is cleared.
>
> I can use another name for the check, e.g. __mcheck_cpu_check_banks()
> or __mcheck_cpu_banks_check_init().

Nevermind, leave it as is. I'll fix it up ontop. I don't like that
"__mcheck_cpu_init" prefixing there which is a mouthful and should
simply be "mce_cpu_<do_stuff>" to denote that it is a function which is
run on a CPU to setup stuff.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
