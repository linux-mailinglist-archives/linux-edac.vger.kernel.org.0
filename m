Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F872264F74
	for <lists+linux-edac@lfdr.de>; Thu, 10 Sep 2020 21:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728054AbgIJTmO (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 10 Sep 2020 15:42:14 -0400
Received: from mx1.tq-group.com ([62.157.118.193]:15843 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731287AbgIJPeg (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 10 Sep 2020 11:34:36 -0400
IronPort-SDR: pCOmsQnRJqe9zlPacUN95X9aFAUhjndCWJzg1blWeKAvwnOj4niYnZo3WzObfZaeIPagK8/GV5
 VIVJAgBbXHIOJUUybzY8mR0RiMhi3U6XsrQiP9LNxu5xSIkuXtwF7Q91H5AmaR/BlnyfDWjUgi
 pJ/bitr10ocAaMZUiu6tvfTKgSwPOxJKpZr8BbVHpHSISSw+oorlnWVV/aoNJLJ2JIB0lQRd1w
 bJqFf6xNddcZOnzbKDCvhwRbZsg971PCRrwKQG6dnLrBCYnkygzEzxfH/K9BpV+olV5HzK2LHm
 oP0=
X-IronPort-AV: E=Sophos;i="5.76,413,1592863200"; 
   d="scan'208";a="13815820"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 10 Sep 2020 17:06:37 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Thu, 10 Sep 2020 17:06:37 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Thu, 10 Sep 2020 17:06:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1599750397; x=1631286397;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=frcCV1k9oG9oKj3dpUqdJg1PxRT2RSN/XKdLCPjaYaY=;
  b=OW9u7L6Z4pq4mADaBmKOtPSkz3HI9ADnBj/yRvA3vsOFoyCsRDWGw3KG
   tGOuver6HlVvBJi4uGpB+uAlBd2CDnSitBTYLJjy+4mWVS5ion59LCEhp
   G5Dyo/M04poRNuzyWR2o9+L3Z+f+BWGIHiNA6q82AzCHI1DUG21ZZhBFd
   xfMzxekSRP7a9QzNTnDICs6O9IWGeVNxgygZPA00gyhsg/OGQ6lXi+0LK
   rCVCFgQZdZrlN7VlLWDxLcwHhMnjn/6kfeLuFndSWuKNMtPqlg93l4Ydb
   dZ0j+QgkzOn85h6IBoEY4voAPsAYI7KyCK9Z+ATitLu9tx1R1UGg8cy74
   g==;
IronPort-SDR: nV6kLyKfx0S0N10OfKe1cWMXV1w1jcBZOvuBpfxAFpqd+3RdAx7BOhaGwemaUsOzDgG+8idN6W
 JL2jpZXNeVvpZiN3w+gLUi01bc3qlDILEQFUZaOP8jVjEo/MggrCu5Fs6l8y38iVFmPbOK4OI4
 YERj9g4EWgNzq2daXmNaZSKe+A4ozEiBOwdz4N2byo8P10+WvmTtVuz9f7sj8fBPme57dO8I+y
 gZlBIMNoN8SnJd476DVdAIMMJQUjTnG7rZkiepaurOew7loh7Yr496O7uDeQ+qXo/YE0G0mbIL
 POY=
X-IronPort-AV: E=Sophos;i="5.76,413,1592863200"; 
   d="scan'208";a="13815819"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 10 Sep 2020 17:06:37 +0200
Received: from herburgerg-w.tq-net.de (herburgerg-w.tq-net.de [10.122.52.145])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id E2F1B280070;
        Thu, 10 Sep 2020 17:06:36 +0200 (CEST)
Date:   Thu, 10 Sep 2020 17:06:28 +0200
From:   Gregor Herburger <gregor.herburger@ew.tq-group.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "york.sun@nxp.com" <york.sun@nxp.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "rrichter@marvell.com" <rrichter@marvell.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        gregor.herburger@ew.tq-group.com
Subject: Re: (EXT) Re: [PATCH v2 1/1] edac: fsl_ddr_edac: fix expected data
 message
Message-ID: <20200910150628.GA26249@herburgerg-w.tq-net.de>
References: <kcEE.e0qfoTd8SOOr3lTVWaXz/A.AASg8YeC1gE@vtuxmail01.tq-net.de>
 <20200904091718.GC21499@zn.tnic>
 <20200904133258.GA21716@herburgerg-w.tq-net.de>
 <20200908192400.GL25236@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200908192400.GL25236@zn.tnic>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org


