Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46187BDF6D
	for <lists+linux-edac@lfdr.de>; Wed, 25 Sep 2019 15:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406057AbfIYNvU (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 25 Sep 2019 09:51:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38664 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406005AbfIYNvT (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 25 Sep 2019 09:51:19 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B67EF308402D;
        Wed, 25 Sep 2019 13:51:19 +0000 (UTC)
Received: from napanee.usersys.redhat.com (dhcp-17-195.bos.redhat.com [10.18.17.195])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 963FF19C7F;
        Wed, 25 Sep 2019 13:51:19 +0000 (UTC)
Received: by napanee.usersys.redhat.com (Postfix, from userid 1000)
        id 20B3BC18A1; Wed, 25 Sep 2019 09:51:19 -0400 (EDT)
Date:   Wed, 25 Sep 2019 09:51:19 -0400
From:   Aristeu Rozanski <aris@redhat.com>
To:     Tony Luck <tony.luck@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-edac@vger.kernel.org
Subject: Re: [PATCH 0/2] EDAC, skx: Provide more machine specific location
 detail
Message-ID: <20190925135118.c5eihll4m55hbsqc@redhat.com>
References: <20190913221344.13055-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190913221344.13055-1-tony.luck@intel.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Wed, 25 Sep 2019 13:51:19 +0000 (UTC)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Sep 13, 2019 at 03:13:42PM -0700, Tony Luck wrote:
> First patch refactors code so that second can work on systems
> with and without the ACPI ADXL address translation code. Perhaps
> has some value on its own as the code is, IMHO, a little cleaner.
> 
> Second is in RFC state. Im looking for input on whether to just print
> the extra information to the console log (as the patch does now) or
> whether to tag it onto the long string that we push though the EDAC
> reporting path.
> 
> Tony Luck (2):
>   EDAC, skx_common: Refactor so that we initialize "dev" in result of
>     adxl decode.
>   EDAC, skx: Retrieve and print retry_rd_err_log registers

with v2:

Acked-by: Aristeu Rozanski <aris@redhat.com>

-- 
Aristeu

