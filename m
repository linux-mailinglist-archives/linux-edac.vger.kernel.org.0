Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E07C2E1AAE
	for <lists+linux-edac@lfdr.de>; Wed, 23 Dec 2020 11:05:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728177AbgLWKEV (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 23 Dec 2020 05:04:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:33754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726022AbgLWKEV (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 23 Dec 2020 05:04:21 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7EEB122288;
        Wed, 23 Dec 2020 10:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608717820;
        bh=87rk0dMOGhi3nicKD3Es/V6n/UdgptV5wLt2t4JBFHo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=H6T/ehVgChsa/ZbadtYkbs/NFOVBxiJHK+XiKYwCeQhrdj7jnMmkMIHWbrVI5wW2X
         6NRJU1wHYpehGzgg+NG5D+7pscY6edDjP9S486NLqW09Lkz1nbUYvl8hEYjQtOd8gG
         H9LKrkV6OD4ttrxGY4clhRpBO/TgFCeTxj4HDGeaD8vGoUqKpnlbOmJ20B6zmGpgyW
         bT3/Hb9VcAMXLCqcExLTewN8//4ogd5XjxmaCKG9WEtpB5QTyubMIXptwBkJtMyZx+
         TYvLcmjxcZQXNm2c7vZQQkNV7QmmBWGciQcYdFnGUFe0mGzgAfjZrCvzvRJssTklTS
         w1fZpAJxSitpg==
Date:   Wed, 23 Dec 2020 11:03:36 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Shiju Jose <shiju.jose@huawei.com>
Cc:     <linux-edac@vger.kernel.org>, <linuxarm@huawei.com>,
        <tanxiaofei@huawei.com>
Subject: Re: [PATCH 3/3] rasdaemon: ras-mc-ctl: Add exception handling
Message-ID: <20201223110336.3c14233c@coco.lan>
In-Reply-To: <20201103142258.1253-4-shiju.jose@huawei.com>
References: <20201103142258.1253-1-shiju.jose@huawei.com>
        <20201103142258.1253-4-shiju.jose@huawei.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Em Tue, 3 Nov 2020 14:22:58 +0000
Shiju Jose <shiju.jose@huawei.com> escreveu:

> Add exception handling in the ras-mc-ctl.
> 
> For example, when an event's table is not present in the SQLite DB,
> then the DBI would detect exception and ras-mc-ctl exit without
> read and log remaining event's information. This would happen
> when an event is not enabled in the rasdaemon. Following is the
> error log when the devlink_event table is not present in the DB,
> "DBD::SQLite::db prepare failed: no such table: devlink_event at ./ras-mc-ctl line 1198.
> Can't call method "execute" on an undefined value at ./ras-mc-ctl line 1199"
> 
> Also disabled the DBI's automatic error logging by setting
> the $dbh->{PrintError} = 0 to avoid duplicate exception logs.

Hmm...


	$ ./util/ras-mc-ctl --summary
	No Memory errors.
	
	No PCIe AER errors.

	No ARM processor errors.
	
	No Extlog errors.
	
	No devlink errors.
	No disk errors.
	Exception: no such table: memory_failure_event

	No MCE errors.

While it sounds a good idea to catch such events, printing it as an
exception doesn't seem the right thing to me, at least for things 
like "no such table".

IMO, it should print something more intuitive, like:

	"Warning: Memory failure detection not enabled"

-

Yet, on a separate note, there's no memory_failure_event upstream.

Maybe I missed some prior patch to be applied before this one?


Thanks,
Mauro
