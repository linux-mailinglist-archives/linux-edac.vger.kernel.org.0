Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C50C42068C2
	for <lists+linux-edac@lfdr.de>; Wed, 24 Jun 2020 02:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387680AbgFXACH (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 23 Jun 2020 20:02:07 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:42652 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387627AbgFXACG (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 23 Jun 2020 20:02:06 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05NNvsSM172350;
        Wed, 24 Jun 2020 00:01:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=P16iDQFvlL+vXgqGvc94tZtbLE8cyS091rvsfygglJg=;
 b=AnnWG9R8JtJr4GqFvNkQubfzSaKn0GpJkLdzwATJ/YN5kDPAdV2F46fZWmzhZxyTlvXq
 up+TEvij5lhDt371IMHdA7zdka+RyyoHzXy1pv8zkucYA/hxJK6aN4SsPqG4ZBri8L1g
 QfuoK+0Ep0/nMxulYfJ26YQh/G56b00uDCxIqXxvlb8ZHBcXojofurvFSM/BecXOVZ7o
 kh/os3PPEBqM9b+VXWe8HG4IlawZIQQB4g4P7jKkxsxTghPgLZQ9EccCVTO0/nFiAwNq
 GVQ4rg33F01D0U4GwY/0ijq3Is1QzMH/mBtCwz2MHJEfy4kfW3oBRnl966c0x3Q3dpjQ tA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 31uustg0r2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 24 Jun 2020 00:01:35 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05NNrHeE187480;
        Wed, 24 Jun 2020 00:01:34 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 31uurq0a30-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Jun 2020 00:01:34 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 05O01SS0030477;
        Wed, 24 Jun 2020 00:01:28 GMT
Received: from localhost (/10.159.232.184)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 24 Jun 2020 00:01:27 +0000
Date:   Tue, 23 Jun 2020 17:01:24 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Luck, Tony" <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-edac@vger.kernel.org, linux-mm@kvack.org,
        linux-nvdimm@lists.01.org, Jane Chu <jane.chu@oracle.com>
Subject: Re: [RFC] Make the memory failure blast radius more precise
Message-ID: <20200624000124.GH7625@magnolia>
References: <20200623201745.GG21350@casper.infradead.org>
 <20200623220412.GA21232@agluck-desk2.amr.corp.intel.com>
 <20200623221741.GH21350@casper.infradead.org>
 <20200623222658.GA21817@agluck-desk2.amr.corp.intel.com>
 <20200623224027.GI21350@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200623224027.GI21350@casper.infradead.org>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9661 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 bulkscore=0 suspectscore=1 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006230159
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9661 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 cotscore=-2147483648 adultscore=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=1 priorityscore=1501 lowpriorityscore=0 clxscore=1011
 impostorscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006230159
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Jun 23, 2020 at 11:40:27PM +0100, Matthew Wilcox wrote:
> On Tue, Jun 23, 2020 at 03:26:58PM -0700, Luck, Tony wrote:
> > On Tue, Jun 23, 2020 at 11:17:41PM +0100, Matthew Wilcox wrote:
> > > It might also be nice to have an madvise() MADV_ZERO option so the
> > > application doesn't have to look up the fd associated with that memory
> > > range, but we haven't floated that idea with the customer yet; I just
> > > thought of it now.
> > 
> > So the conversation between OS and kernel goes like this?
> > 
> > 1) machine check
> > 2) Kernel unmaps the 4K page surroundinng the poison and sends
> >    SIGBUS to the application to say that one cache line is gone
> > 3) App says madvise(MADV_ZERO, that cache line)
> > 4) Kernel says ... "oh, you know how to deal with this" and allocates
> >    a new page, copying the 63 good cache lines from the old page and
> >    zeroing the missing one. New page is mapped to user.
> 
> That could be one way of implementing it.  My understanding is that
> pmem devices will reallocate bad cachelines on writes, so a better
> implementation would be:
> 
> 1) Kernel receives machine check
> 2) Kernel sends SIGBUS to the application
> 3) App send madvise(MADV_ZERO, addr, 1 << granularity)
> 4) Kernel does special writes to ensure the cacheline is zeroed
> 5) App does whatever it needs to recover (reconstructs the data or marks
> it as gone)

Frankly, I've wondered why the filesystem shouldn't just be in charge of
all this--

1. kernel receives machine check
2. kernel tattles to xfs
3. xfs looks up which file(s) own the pmem range
4. xfs zeroes the region, clears the poison, and sets AS_EIO on the
   files
5. xfs sends SIGBUS to any programs that had those files mapped to tell
   them "Your data is gone, we've stabilized the storage you had
   mapped."
6. app does whatever it needs to recover

Apps shouldn't have to do this punch-and-reallocate dance, seeing as
they don't currently do that for SCSI disks and the like.

--D

> > Do you have folks lined up to use that?  I don't know that many
> > folks are even catching the SIGBUS :-(
> 
> Had a 75 minute meeting with some people who want to use pmem this
> afternoon ...
