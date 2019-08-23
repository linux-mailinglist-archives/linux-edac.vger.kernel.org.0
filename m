Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0911A9B449
	for <lists+linux-edac@lfdr.de>; Fri, 23 Aug 2019 18:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388997AbfHWQKm (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 23 Aug 2019 12:10:42 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57536 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732570AbfHWQKm (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 23 Aug 2019 12:10:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=owE6ZNynyIUnXS+Pkj9xw1pRzw4t/OvQGMYV9S2Mdgk=; b=JhvvxXG9dIP+GookOngtfC1ha
        xztVWWamjRDd19oAMjklQWwJcEs2qKOc+xhE5Dgrq5QaqdbGiV1AgMwJ4iBm4T7mKUw/NK9Bwobg2
        vCu6IK9xaeiFEQt+rF7Xr/ELoFIHtKanCS/NXP0cVfOLGtQumRoLD35Hi+x8mdnfeXV65zaP2s4/K
        6mGi9xG3IVuEMTdWCFLWaeH5l0oBF+a8vuiYH7bPDvZuSP17McgInXeO3913LJjSMwv/eT5ND6/hU
        tRo8NZzxn7QFo5rqVH2K6305o/Q7UNIrCjPF4sTuOcjLvESfFl5arE4a2gBVgzmwb6MVEkyzG//dy
        7l8m9RwpA==;
Received: from [177.133.63.56] (helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i1C9B-0002Xm-6g
        for linux-edac@vger.kernel.org; Fri, 23 Aug 2019 16:10:41 +0000
Date:   Fri, 23 Aug 2019 13:10:38 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     linux-edac@vger.kernel.org
Subject: [ANN] Rasdaemon version 0.6.3 released
Message-ID: <20190823131020.7cfe87f6@coco.lan>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi all,

Just released today a new version of the rasdaemon with:

	* Added support for ARM Scalable MCA
	* Added support for HiSilicon HIP08
	* Added support for Hygon Dhyana family 18h processor
	* Added support for disk I/O error monitoring
	* Added devlink events
	* Integrate rasdaemon build tests with Travis CI
	* Fixed asdaemon high CPU usage when part of CPUs offline
	* Fixed mcgstatus message print
	* Some other minor fixes

Also, ./configure has gained a new option:

	./configure --enable-all

With enables all features when building it at the tool. Very helpful 
to test if everything is ok. Please notice that this option enables 
arch-specific features for reports on both ARM and x86 architectures.
It should still run fine - although it may report that some feats aren't
available when you try to run it.

The main git repository is hosted at:

	https://github.com/mchehab/rasdaemon

CI testing is available at:

	https://travis-ci.org/mchehab/rasdaemon

Source tarballs at:

	https://www.infradead.org/~mchehab/rasdaemon/

And Fedora packages (Fedora 30, 31 and rawhide) at:
	https://koji.fedoraproject.org/koji/packageinfo?packageID=16220

Thanks,
Mauro
