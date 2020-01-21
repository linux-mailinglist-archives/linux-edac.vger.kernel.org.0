Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF8D5144418
	for <lists+linux-edac@lfdr.de>; Tue, 21 Jan 2020 19:13:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729080AbgAUSNa (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 21 Jan 2020 13:13:30 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47064 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728186AbgAUSNa (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 21 Jan 2020 13:13:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579630407;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZUtCSu3aDvI3z1XINUeecd42d+AAUP55P9sbendKUdI=;
        b=BC4EvxIzYK5uFPgp+7ksEj9HBZeBdzna70fxaFUQVP8hJG9aovD37EOwj70EQnmJTeSwNn
        ym5gf0nJqau84I1RbGVaNjUcgquQXjZw6cTFvl97y3v11CxEeajs4QsswIOambB5Srx894
        ZQKZyQdbYoIE+xn+ACJvxqZOgIexlJs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-22--1D2Uqe1NOy-SERY9VGZdQ-1; Tue, 21 Jan 2020 13:13:25 -0500
X-MC-Unique: -1D2Uqe1NOy-SERY9VGZdQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2F9BB800D41;
        Tue, 21 Jan 2020 18:13:23 +0000 (UTC)
Received: from napanee.usersys.redhat.com (dhcp-17-195.bos.redhat.com [10.18.17.195])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 857738BE10;
        Tue, 21 Jan 2020 18:13:22 +0000 (UTC)
Received: by napanee.usersys.redhat.com (Postfix, from userid 1000)
        id 1D24BC0D9A; Tue, 21 Jan 2020 13:13:22 -0500 (EST)
Date:   Tue, 21 Jan 2020 13:13:22 -0500
From:   Aristeu Rozanski <aris@redhat.com>
To:     Robert Richter <rrichter@marvell.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        John Garry <john.garry@huawei.com>
Subject: Re: [PATCH] EDAC/mc: Fix use-after-free and memleaks during device
 removal
Message-ID: <20200121181322.2suw5osy4tim65rl@redhat.com>
References: <20191218062129.7400-1-rrichter@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191218062129.7400-1-rrichter@marvell.com>
User-Agent: NeoMutt/20191207
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Dec 18, 2019 at 06:22:08AM +0000, Robert Richter wrote:
> A test kernel with the options set below revealed several issues when
> removing a mci device:
> 
>  DEBUG_TEST_DRIVER_REMOVE
>  KASAN
>  DEBUG_KMEMLEAK
> 
> Issues seen:
> 
> 1) Use-after-free:
> 
> On 27.11.19 17:07:33, John Garry wrote:
> > [   22.104498] BUG: KASAN: use-after-free in
> > edac_remove_sysfs_mci_device+0x148/0x180
> 
> The use-after-free is triggered in edac_remove_sysfs_mci_device(). It
> became an issue with commit c498afaf7df8 ("EDAC: Introduce an
> mci_for_each_dimm() iterator").
> 
> The reason for it is that device_unregister(&dimm->dev) not only
> removes the sysfs entry, it also frees the dimm struct in
> dimm_attr_release(). When incrementing the loop in
> mci_for_each_dimm(), the dimm struct is accessed again by the loop
> iterator which causes the use-after-free.
> 
> In function edac_remove_sysfs_mci_device() all the mci device's
> subsequent dimm and csrow objects are removed. When unregistering from
> sysfs, instead of removing that data it should be kept until it is
> removed together with the mci device. This keeps the data structures
> intact and the mci device can be fully used until it will be removed.
> 
> 2) Memory leaks:
> 
> Following memory leaks have been detected:
> 
>  # grep edac /sys/kernel/debug/kmemleak | sort | uniq -c
>        1     [<000000003c0f58f9>] edac_mc_alloc+0x3bc/0x9d0      # mci->csrows
>       16     [<00000000bb932dc0>] edac_mc_alloc+0x49c/0x9d0      # csr->channels
>       16     [<00000000e2734dba>] edac_mc_alloc+0x518/0x9d0      # csr->channels[chn]
>        1     [<00000000eb040168>] edac_mc_alloc+0x5c8/0x9d0      # mci->dimms
>       34     [<00000000ef737c29>] ghes_edac_register+0x1c8/0x3f8 # see edac_mc_alloc()
> 
> There are two implementions for device removal in the driver. One is
> used before edac_mc_add_mc(), the other afterwards after the device
> had been registered in sysfs. The later lacks the removal of some data
> allocated in edac_mc_alloc(). All the above issues are fixed as
> follows:
> 
> Unify release code in a single mci_release() function and use this one
> together with put_device() to release the struct mci once there are no
> users. Free all subsequent data structures of the children devices in
> that release function too. An effect of this is that no data is freed
> in edac_mc_sysfs.c (except the "mc" sysfs root node). All sysfs
> entries have the mci device as a parent, so its refcount will keep the
> struct from being removed as long as sysfs entries exist. Before
> freeing struct mci, all sysfs entries are removed now in edac_remove_
> sysfs_mci_device(). With the changes made the mci_for_each_dimm() loop
> is now save to remove dimm devices from sysfs.
> 
> The patch has been tested with the above kernel options, no issues
> seen any longer.
> 
> This patch should be marked as stable.
> 
> Reported-by: John Garry <john.garry@huawei.com>
> Signed-off-by: Robert Richter <rrichter@marvell.com>
> ---
>  drivers/edac/edac_mc.c       |  20 +++----
>  drivers/edac/edac_mc_sysfs.c | 100 +++++++++++++----------------------
>  drivers/edac/edac_module.h   |   1 -
>  3 files changed, 49 insertions(+), 72 deletions(-)
> 
> diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
> index 7243b88f81d8..058efcd9032e 100644
> --- a/drivers/edac/edac_mc.c
> +++ b/drivers/edac/edac_mc.c
> @@ -278,6 +278,12 @@ void *edac_align_ptr(void **p, unsigned int size, int n_elems)
>  
>  static void _edac_mc_free(struct mem_ctl_info *mci)
>  {
> +	put_device(&mci->dev);
> +}
> +
> +static void mci_release(struct device *dev)
> +{
> +	struct mem_ctl_info *mci = container_of(dev, struct mem_ctl_info, dev);
>  	struct csrow_info *csr;
>  	int i, chn, row;
>  
> @@ -371,6 +377,9 @@ struct mem_ctl_info *edac_mc_alloc(unsigned int mc_num,
>  	if (mci == NULL)
>  		return NULL;
>  
> +	mci->dev.release = mci_release;
> +	device_initialize(&mci->dev);
> +
>  	/* Adjust pointers so they point within the memory we just allocated
>  	 * rather than an imaginary chunk of memory located at address 0.
>  	 */
> @@ -505,16 +514,9 @@ void edac_mc_free(struct mem_ctl_info *mci)
>  {
>  	edac_dbg(1, "\n");
>  
> -	/* If we're not yet registered with sysfs free only what was allocated
> -	 * in edac_mc_alloc().
> -	 */
> -	if (!device_is_registered(&mci->dev)) {
> -		_edac_mc_free(mci);
> -		return;
> -	}
> +	edac_remove_sysfs_mci_device(mci);
>  
> -	/* the mci instance is freed here, when the sysfs object is dropped */
> -	edac_unregister_sysfs(mci);
> +	_edac_mc_free(mci);
>  }
>  EXPORT_SYMBOL_GPL(edac_mc_free);
>  
> diff --git a/drivers/edac/edac_mc_sysfs.c b/drivers/edac/edac_mc_sysfs.c
> index 0367554e7437..408bace699dc 100644
> --- a/drivers/edac/edac_mc_sysfs.c
> +++ b/drivers/edac/edac_mc_sysfs.c
> @@ -274,17 +274,8 @@ static const struct attribute_group *csrow_attr_groups[] = {
>  	NULL
>  };
>  
> -static void csrow_attr_release(struct device *dev)
> -{
> -	struct csrow_info *csrow = container_of(dev, struct csrow_info, dev);
> -
> -	edac_dbg(1, "device %s released\n", dev_name(dev));
> -	kfree(csrow);
> -}
> -
>  static const struct device_type csrow_attr_type = {
>  	.groups		= csrow_attr_groups,
> -	.release	= csrow_attr_release,
>  };
>  
>  /*
> @@ -390,6 +381,14 @@ static const struct attribute_group *csrow_dev_groups[] = {
>  	NULL
>  };
>  
> +static void csrow_release(struct device *dev)
> +{
> +	/*
> +	 * Nothing to do. We just unregister sysfs here. The mci
> +	 * device owns the data and will also release it.
> +	 */
> +}
> +
>  static inline int nr_pages_per_csrow(struct csrow_info *csrow)
>  {
>  	int chan, nr_pages = 0;
> @@ -408,6 +407,7 @@ static int edac_create_csrow_object(struct mem_ctl_info *mci,
>  
>  	csrow->dev.type = &csrow_attr_type;
>  	csrow->dev.groups = csrow_dev_groups;
> +	csrow->dev.release = csrow_release;
>  	device_initialize(&csrow->dev);
>  	csrow->dev.parent = &mci->dev;
>  	csrow->mci = mci;
> @@ -444,11 +444,8 @@ static int edac_create_csrow_objects(struct mem_ctl_info *mci)
>  
>  error:
>  	for (--i; i >= 0; i--) {
> -		csrow = mci->csrows[i];
> -		if (!nr_pages_per_csrow(csrow))
> -			continue;
> -
> -		device_del(&mci->csrows[i]->dev);
> +		if (device_is_registered(&mci->csrows[i]->dev))
> +			device_unregister(&mci->csrows[i]->dev);
>  	}
>  
>  	return err;
> @@ -457,15 +454,13 @@ static int edac_create_csrow_objects(struct mem_ctl_info *mci)
>  static void edac_delete_csrow_objects(struct mem_ctl_info *mci)
>  {
>  	int i;
> -	struct csrow_info *csrow;
>  
> -	for (i = mci->nr_csrows - 1; i >= 0; i--) {
> -		csrow = mci->csrows[i];
> -		if (!nr_pages_per_csrow(csrow))
> -			continue;
> -		device_unregister(&mci->csrows[i]->dev);
> +	for (i = 0; i < mci->nr_csrows; i++) {
> +		if (device_is_registered(&mci->csrows[i]->dev))
> +			device_unregister(&mci->csrows[i]->dev);
>  	}
>  }
> +
>  #endif
>  
>  /*
> @@ -606,19 +601,18 @@ static const struct attribute_group *dimm_attr_groups[] = {
>  	NULL
>  };
>  
> -static void dimm_attr_release(struct device *dev)
> -{
> -	struct dimm_info *dimm = container_of(dev, struct dimm_info, dev);
> -
> -	edac_dbg(1, "device %s released\n", dev_name(dev));
> -	kfree(dimm);
> -}
> -
>  static const struct device_type dimm_attr_type = {
>  	.groups		= dimm_attr_groups,
> -	.release	= dimm_attr_release,
>  };
>  
> +static void dimm_release(struct device *dev)
> +{
> +	/*
> +	 * Nothing to do. We just unregister sysfs here. The mci
> +	 * device owns the data and will also release it.
> +	 */
> +}
> +
>  /* Create a DIMM object under specifed memory controller device */
>  static int edac_create_dimm_object(struct mem_ctl_info *mci,
>  				   struct dimm_info *dimm)
> @@ -627,6 +621,7 @@ static int edac_create_dimm_object(struct mem_ctl_info *mci,
>  	dimm->mci = mci;
>  
>  	dimm->dev.type = &dimm_attr_type;
> +	dimm->dev.release = dimm_release;
>  	device_initialize(&dimm->dev);
>  
>  	dimm->dev.parent = &mci->dev;
> @@ -891,17 +886,8 @@ static const struct attribute_group *mci_attr_groups[] = {
>  	NULL
>  };
>  
> -static void mci_attr_release(struct device *dev)
> -{
> -	struct mem_ctl_info *mci = container_of(dev, struct mem_ctl_info, dev);
> -
> -	edac_dbg(1, "device %s released\n", dev_name(dev));
> -	kfree(mci);
> -}
> -
>  static const struct device_type mci_attr_type = {
>  	.groups		= mci_attr_groups,
> -	.release	= mci_attr_release,
>  };
>  
>  /*
> @@ -920,8 +906,6 @@ int edac_create_sysfs_mci_device(struct mem_ctl_info *mci,
>  
>  	/* get the /sys/devices/system/edac subsys reference */
>  	mci->dev.type = &mci_attr_type;
> -	device_initialize(&mci->dev);
> -
>  	mci->dev.parent = mci_pdev;
>  	mci->dev.groups = groups;
>  	dev_set_name(&mci->dev, "mc%d", mci->mc_idx);
> @@ -931,7 +915,7 @@ int edac_create_sysfs_mci_device(struct mem_ctl_info *mci,
>  	err = device_add(&mci->dev);
>  	if (err < 0) {
>  		edac_dbg(1, "failure: create device %s\n", dev_name(&mci->dev));
> -		put_device(&mci->dev);
> +		/* no put_device() here, free mci with _edac_mc_free() */
>  		return err;
>  	}
>  
> @@ -947,24 +931,20 @@ int edac_create_sysfs_mci_device(struct mem_ctl_info *mci,
>  
>  		err = edac_create_dimm_object(mci, dimm);
>  		if (err)
> -			goto fail_unregister_dimm;
> +			goto fail;
>  	}
>  
>  #ifdef CONFIG_EDAC_LEGACY_SYSFS
>  	err = edac_create_csrow_objects(mci);
>  	if (err < 0)
> -		goto fail_unregister_dimm;
> +		goto fail;
>  #endif
>  
>  	edac_create_debugfs_nodes(mci);
>  	return 0;
>  
> -fail_unregister_dimm:
> -	mci_for_each_dimm(mci, dimm) {
> -		if (device_is_registered(&dimm->dev))
> -			device_unregister(&dimm->dev);
> -	}
> -	device_unregister(&mci->dev);
> +fail:
> +	edac_remove_sysfs_mci_device(mci);
>  
>  	return err;
>  }
> @@ -976,6 +956,9 @@ void edac_remove_sysfs_mci_device(struct mem_ctl_info *mci)
>  {
>  	struct dimm_info *dimm;
>  
> +	if (!device_is_registered(&mci->dev))
> +		return;
> +
>  	edac_dbg(0, "\n");
>  
>  #ifdef CONFIG_EDAC_DEBUG
> @@ -986,17 +969,14 @@ void edac_remove_sysfs_mci_device(struct mem_ctl_info *mci)
>  #endif
>  
>  	mci_for_each_dimm(mci, dimm) {
> -		if (dimm->nr_pages == 0)
> +		if (!device_is_registered(&dimm->dev))
>  			continue;
>  		edac_dbg(1, "unregistering device %s\n", dev_name(&dimm->dev));
>  		device_unregister(&dimm->dev);
>  	}
> -}
>  
> -void edac_unregister_sysfs(struct mem_ctl_info *mci)
> -{
> -	edac_dbg(1, "unregistering device %s\n", dev_name(&mci->dev));
> -	device_unregister(&mci->dev);
> +	/* only remove the device, but keep mci */
> +	device_del(&mci->dev);
>  }
>  
>  static void mc_attr_release(struct device *dev)
> @@ -1010,9 +990,6 @@ static void mc_attr_release(struct device *dev)
>  	kfree(dev);
>  }
>  
> -static const struct device_type mc_attr_type = {
> -	.release	= mc_attr_release,
> -};
>  /*
>   * Init/exit code for the module. Basically, creates/removes /sys/class/rc
>   */
> @@ -1025,11 +1002,10 @@ int __init edac_mc_sysfs_init(void)
>  		return -ENOMEM;
>  
>  	mci_pdev->bus = edac_get_sysfs_subsys();
> -	mci_pdev->type = &mc_attr_type;
> -	device_initialize(mci_pdev);
> -	dev_set_name(mci_pdev, "mc");
> +	mci_pdev->release = mc_attr_release;
> +	mci_pdev->init_name = "mc";
>  
> -	err = device_add(mci_pdev);
> +	err = device_register(mci_pdev);
>  	if (err < 0) {
>  		edac_dbg(1, "failure: create device %s\n", dev_name(mci_pdev));
>  		put_device(mci_pdev);
> diff --git a/drivers/edac/edac_module.h b/drivers/edac/edac_module.h
> index 388427d378b1..aa1f91688eb8 100644
> --- a/drivers/edac/edac_module.h
> +++ b/drivers/edac/edac_module.h
> @@ -28,7 +28,6 @@ void edac_mc_sysfs_exit(void);
>  extern int edac_create_sysfs_mci_device(struct mem_ctl_info *mci,
>  					const struct attribute_group **groups);
>  extern void edac_remove_sysfs_mci_device(struct mem_ctl_info *mci);
> -void edac_unregister_sysfs(struct mem_ctl_info *mci);
>  extern int edac_get_log_ue(void);
>  extern int edac_get_log_ce(void);
>  extern int edac_get_panic_on_ue(void);

Acked-by: Aristeu Rozanski <aris@redhat.com>

-- 
Aristeu

