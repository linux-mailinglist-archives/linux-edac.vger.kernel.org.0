Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B44751FD03B
	for <lists+linux-edac@lfdr.de>; Wed, 17 Jun 2020 17:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbgFQPDC (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 17 Jun 2020 11:03:02 -0400
Received: from winnie.ispras.ru ([83.149.199.91]:29581 "EHLO smtp.ispras.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726329AbgFQPDC (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 17 Jun 2020 11:03:02 -0400
X-Greylist: delayed 503 seconds by postgrey-1.27 at vger.kernel.org; Wed, 17 Jun 2020 11:03:02 EDT
Received: from monopod.intra.ispras.ru (monopod.intra.ispras.ru [10.10.3.121])
        by smtp.ispras.ru (Postfix) with ESMTP id 735F8203BF;
        Wed, 17 Jun 2020 17:54:36 +0300 (MSK)
Date:   Wed, 17 Jun 2020 17:54:36 +0300 (MSK)
From:   Alexander Monakov <amonakov@ispras.ru>
To:     Jacky Hu <hengqing.hu@gmail.com>
cc:     Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        tony.luck@intel.com, x86@kernel.org, yazen.ghannam@amd.com,
        bp@alien8.de, clemens@ladisch.de
Subject: Re: [PATCH] hwmon: (k10temp) Add AMD family 17h model 60h probe
In-Reply-To: <20200617071927.GA398128@i716>
Message-ID: <alpine.LNX.2.20.13.2006171739010.31660@monopod.intra.ispras.ru>
References: <20200616180940.GN13515@zn.tnic> <20200617013255.391975-1-hengqing.hu@gmail.com> <20200617034028.GA1614@roeck-us.net> <20200617071927.GA398128@i716>
User-Agent: Alpine 2.20.13 (LNX 116 2015-12-14)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi,

I've already said in my patch submission (which was Cc'ed to LKML,
linux-edac and linux-hwmon so you should have been able to find it):

>> It appears SMU offsets for reading current/voltage and CCD temperature
>> have changed for this generation (reads from currently used offsets
>> yield zeros), so those features cannot be enabled so trivially.

In https://github.com/FlyGoat/ryzen_nb_smu/issues/3 there some
reverse-engineered info that indicates that for Renoir, SMU region has been
moved to 0x6F000. Its layout also changed, as far as I can tell.

(also, please ask yourself if you want to offer the maintainers an apology)

Alexander
