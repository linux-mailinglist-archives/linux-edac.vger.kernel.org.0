Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F32456BF903
	for <lists+linux-edac@lfdr.de>; Sat, 18 Mar 2023 09:36:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbjCRIgI (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 18 Mar 2023 04:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjCRIgH (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sat, 18 Mar 2023 04:36:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF775A76B9
        for <linux-edac@vger.kernel.org>; Sat, 18 Mar 2023 01:36:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 67F33B80E8E
        for <linux-edac@vger.kernel.org>; Sat, 18 Mar 2023 08:35:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91458C433EF;
        Sat, 18 Mar 2023 08:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679128558;
        bh=IIT3sW15hLQTJZE2wLizpv+F767u+WJoyMCJaPLa3iI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tsOLuS8IupgJRUrJK3f+joxBxxl+xWTW1b4wq23qb8ehFFzBudq+lfjsuBej2G3z/
         kiuroLN2WPsqAEVXMrCSBWj7WxTMfFDMtahszaie6a9cgM7KTDCykoMztBr/LWjvHX
         BIZm0Y2A/p4pNfYL5Zm4M6yESny4ZrKYc1nWOL1fgyQ5gCMvVycrdxkDeSwOpCyMTV
         RZpiUMQWRg4BnjdyO5Or3GwQzUGITjDaXPnvrUrM6Le+VD8EOY8s+Jh7Ol6dkXAmhd
         8X9dJjluYSHOaw9JUjRKfpxr1LkPCxu190oDfvjOffNCoICO8XrhoHAKviogI0tIJH
         mEaM4J+nsj+aA==
Date:   Sat, 18 Mar 2023 09:35:53 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     <shiju.jose@huawei.com>
Cc:     <linux-edac@vger.kernel.org>, <tanxiaofei@huawei.com>,
        <fenglei47@h-partners.com>, <jonathan.cameron@huawei.com>,
        <linuxarm@huawei.com>
Subject: Re: [PATCH 1/1] rasdaemon: Fix for regression in
 ras_mc_create_table() if some cpus are offline at the system start
Message-ID: <20230318093553.3e524594@coco.lan>
In-Reply-To: <20230314105725.1184-1-shiju.jose@huawei.com>
References: <20230314105725.1184-1-shiju.jose@huawei.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Jose,

Em Tue, 14 Mar 2023 10:57:25 +0000
<shiju.jose@huawei.com> escreveu:

> From: Shiju Jose <shiju.jose@huawei.com>
> 
> Issues:
> Regression in the ras_mc_create_table() if some of the cpus are offline
> at the system start when run the rasdaemon. This issue is
> reproducible in ras_mc_create_table() with decode and record
> non-standard events and reproducible sometimes with
> ras_mc_create_table() for the standard events.
> Also in the multi thread way, there is memory leak in ras_mc_event_opendb()
> as struct sqlite3_priv *priv and sqlite3 *db allocated/initialized per
> thread, but stored in the common struct ras_events ras in pthread data,
> which is shared across the threads. 

Could you please submit rasdaemon patches via github pull requests?

It is currently easier to me to pick patches from there. You can still
send then to the ML in case you want others to take a look and review
them, but I'll be applying them only after the PR at rasdaemon.

Regards,
Mauro

> 
> Reason:
> when the system start with some of the cpus are offline and then run
> the rasdaemon, read_ras_event_all_cpus() exit with error and switch to
> the multi thread way. However read() in read_ras_event() return error in
> threads for each of the offline CPUs and does clean up including calling
> ras_mc_event_closedb().
> Since the 'struct ras_events ras' passed in the pthread_data to each of the
> threads is common, struct sqlite3_priv *priv and sqlite3 *db allocated/
> initialized per thread and stored in the common 'struct ras_events ras',
> are getting overwritten in each ras_mc_event_opendb()(which called from
> pthread per cpu), result memory leak. Also when ras_mc_event_closedb()
> is called in the above error case from the threads corresponding to the
> offline cpus, close the sqlite3 *db and free sqlite3_priv *priv stored
> in the common 'struct ras_events ras', result regression when accessing
> priv->db in the ras_mc_create_table() from another context later.
> 
> Proposed solution:
> In ras_mc_event_opendb(), allocate struct sqlite3_priv *priv,
> init sqlite3 *db and create tables common for the threads with shared
> 'struct ras_events ras' based on a reference count and free them in the
> same way.
> Also protect critical code ras_mc_event_opendb() and ras_mc_event_closedb()
> using mutex in the multi thread case from any regression caused by the
> thread pre-emption.
> 
> Reported-by: Lei Feng <fenglei47@h-partners.com>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> ---
>  ras-events.c | 16 +++++++++++++++-
>  ras-events.h |  4 +++-
>  ras-record.c |  9 +++++++++
>  3 files changed, 27 insertions(+), 2 deletions(-)
> 
> diff --git a/ras-events.c b/ras-events.c
> index 49e4f9a..4d21af3 100644
> --- a/ras-events.c
> +++ b/ras-events.c
> @@ -625,19 +625,25 @@ static void *handle_ras_events_cpu(void *priv)
>  
>  	log(TERM, LOG_INFO, "Listening to events on cpu %d\n", pdata->cpu);
>  	if (pdata->ras->record_events) {
> +		pthread_mutex_lock(&pdata->ras->db_lock);
>  		if (ras_mc_event_opendb(pdata->cpu, pdata->ras)) {
> +			pthread_mutex_unlock(&pdata->ras->db_lock);
>  			log(TERM, LOG_ERR, "Can't open database\n");
>  			close(fd);
>  			kbuffer_free(kbuf);
>  			free(page);
>  			return 0;
>  		}
> +		pthread_mutex_unlock(&pdata->ras->db_lock);
>  	}
>  
>  	read_ras_event(fd, pdata, kbuf, page);
>  
> -	if (pdata->ras->record_events)
> +	if (pdata->ras->record_events) {
> +		pthread_mutex_lock(&pdata->ras->db_lock);
>  		ras_mc_event_closedb(pdata->cpu, pdata->ras);
> +		pthread_mutex_unlock(&pdata->ras->db_lock);
> +	}
>  
>  	close(fd);
>  	kbuffer_free(kbuf);
> @@ -993,6 +999,11 @@ int handle_ras_events(int record_events)
>  
>  	/* Poll doesn't work on this kernel. Fallback to pthread way */
>  	if (rc == -255) {
> +		if (pthread_mutex_init(&ras->db_lock, NULL) != 0) {
> +			log(SYSLOG, LOG_INFO, "sqlite db lock init has failed\n");
> +			goto err;
> +		}
> +
>  		log(SYSLOG, LOG_INFO,
>  		"Opening one thread per cpu (%d threads)\n", cpus);
>  		for (i = 0; i < cpus; i++) {
> @@ -1005,6 +1016,8 @@ int handle_ras_events(int record_events)
>  				i);
>  				while (--i)
>  					pthread_cancel(data[i].thread);
> +
> +				pthread_mutex_destroy(&ras->db_lock);
>  				goto err;
>  			}
>  		}
> @@ -1012,6 +1025,7 @@ int handle_ras_events(int record_events)
>  		/* Wait for all threads to complete */
>  		for (i = 0; i < cpus; i++)
>  			pthread_join(data[i].thread, NULL);
> +		pthread_mutex_destroy(&ras->db_lock);
>  	}
>  
>  	log(SYSLOG, LOG_INFO, "Huh! something got wrong. Aborting.\n");
> diff --git a/ras-events.h b/ras-events.h
> index 6c9f507..649b0c0 100644
> --- a/ras-events.h
> +++ b/ras-events.h
> @@ -56,7 +56,9 @@ struct ras_events {
>  	time_t		uptime_diff;
>  
>  	/* For ras-record */
> -	void		*db_priv;
> +	void	*db_priv;
> +	int	db_ref_count;
> +	pthread_mutex_t db_lock;
>  
>  	/* For the mce handler */
>  	struct mce_priv	*mce_priv;
> diff --git a/ras-record.c b/ras-record.c
> index a367939..171704a 100644
> --- a/ras-record.c
> +++ b/ras-record.c
> @@ -763,6 +763,10 @@ int ras_mc_event_opendb(unsigned cpu, struct ras_events *ras)
>  
>  	printf("Calling %s()\n", __FUNCTION__);
>  
> +	ras->db_ref_count++;
> +	if (ras->db_ref_count > 1)
> +		return 0;
> +
>  	ras->db_priv = NULL;
>  
>  	priv = calloc(1, sizeof(*priv));
> @@ -912,6 +916,13 @@ int ras_mc_event_closedb(unsigned int cpu, struct ras_events *ras)
>  
>  	printf("Calling %s()\n", __func__);
>  
> +	if (ras->db_ref_count > 0)
> +		ras->db_ref_count--;
> +	else
> +		return -1;
> +	if (ras->db_ref_count > 0)
> +		return 0;
> +
>  	if (!priv)
>  		return -1;
>  
> @@ -1018,6 +1026,7 @@ int ras_mc_event_closedb(unsigned int cpu, struct ras_events *ras)
>  		log(TERM, LOG_ERR,
>  		    "cpu %u: Failed to shutdown sqlite: error = %d\n", cpu, rc);
>  	free(priv);
> +	ras->db_priv = NULL;
>  
>  	return 0;
>  }



Thanks,
Mauro
